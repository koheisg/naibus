class SlackController < ActionController::API
  def endpoint
    if params["event"]["type"] == 'url_verification'
      render json: { challenge: params[:challenge] }, status: 200
    elsif params["event"]["type"] == 'app_mention'
      workspace = Workspace.find_by!(workspace_code: params[:team_id])
      thread = ChatThread.new(message_code: params[:event][:client_msg_id],
                              role: :user,
                              team_code: params[:team_id],
                              channel_code: params.dig("event","channel"),
                              ts_code: params["event"]["thread_ts"] || params["event"]["ts"],
                              message: params["event"]["text"].gsub(/<@.*?> /, ''))
      if thread.save
        SlackAppMentionJob.perform_later(workspace, thread)
      end
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
      access_token = res['access_token']
      workspace_id = res['team']['id']
      Workspace.upsert({workspace_code: workspace_id,
                        access_token: access_token}, unique_by: workspace_id)
      session[:workspace_id] = Workspace.find_by!(workspace_code: workspace_id).id
      redirect_to edit_workspace_path
    else
      flash[:error] = "Slackアプリのインストールに失敗しました。"
      redirect_to root_path
    end
  end
end
