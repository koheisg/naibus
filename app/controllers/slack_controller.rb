# frozen_string_literal: true

class SlackController < ActionController::API
  def endpoint
    if params['event']['type'] == 'url_verification'
      render json: { challenge: params[:challenge] }, status: 200
    elsif params['event']['type'] == 'app_mention'
      workspace = Workspace.find_by!(workspace_code: params[:team_id])
      thread = ChatThread.new(message_code: params[:event][:client_msg_id],
                              role: :user,
                              team_code: params[:team_id],
                              channel_code: params.dig('event', 'channel'),
                              ts_code: params['event']['thread_ts'] || params['event']['ts'],
                              message: params['event']['text'].gsub(/<@.*?> /, ''))
      SlackAppMentionJob.perform_later(workspace, thread) if thread.save
      render json: '', status: 200
    elsif params['event']['type'] == 'reaction_added' && params['event']['reaction'] == 'naibus'
      workspace = Workspace.find_by!(workspace_code: params['authorizations'][0]['team_id'])
      SlackRetriveConversationJob.perform_later(workspace,
                                                params['event']['item']['channel'],
                                                params['event']['item']['ts'])
      render json: '', status: 200
    else
      render json: '', status: 200
    end
  end

  def auth_callback
    if params[:error]
      flash[:error] = "Slackアプリのインストールに失敗しました。[#{params[:error]}]"
      return redirect_to root_path
    end

    client = Slack::Web::Client.new
    res = client.oauth_v2_access(
      client_id: ENV['SLACK_CLIENT_ID'],
      client_secret: ENV['SLACK_CLIENT_SECRET'],
      code: params[:code],
      redirect_uri: ENV['SLACK_REDIRECT_URI']
    )
    if res['ok']
      User.create!(slack_user_id: res['authed_user']['id'])
      access_token = res['access_token']
      workspace_id = res['team']['id']
      workspace = Workspace.find_by(workspace_code: workspace_id)
      if workspace
        workspace.update!(access_token:)
      else
        workspace = Workspace.create!(workspace_code: workspace_id,
                                      access_token:)
      end
      session[:workspace_id] = workspace.id
      redirect_to edit_workspace_path
    else
      flash[:error] = 'Slackアプリのインストールに失敗しました。'
      redirect_to root_path
    end
  end
end
