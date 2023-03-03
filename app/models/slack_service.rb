class SlackService
  def self.call(params)
    if params["event"]["type"] == 'url_verification'
      { challenge: params[:challenge] }
    elsif params["event"]["type"] == 'app_mention'
      text = params["event"]["text"].gsub(/<@.*> /, '')
      workspace = Workspace.find_by(workspace_code: params[:team_id])
      text = OpenAiService.call(text, workspace.openai_access_token)
      Slack::Web::Client.new.chat_postMessage(text: text,
                                              thread_ts: params["event"]["ts"],
                                              channel: params["event"]["channel"],
                                              as_user: true)
      ''
    else
      ''
    end
  end
end
