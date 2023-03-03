class SlackController < ActionController::API
  def endpoint
    res = SlackService.call(params)
    render json: res, status: 200
  end

  def auth_callback
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
      workspace = Workspace.find_or_create_by(workspace_code: workspace_id)
      workspace.update(access_token: access_token)
      session[:workspace_id] = workspace.id
      redirect_to root_path
    else
      flash[:error] = "Slackアプリのインストールに失敗しました。"
      redirect_to root_path
    end
  end
end
