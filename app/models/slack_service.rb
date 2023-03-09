class SlackService
  def self.call(params)
    if params["event"]["type"] == 'url_verification'
      { challenge: params[:challenge] }
    elsif params["event"]["type"] == 'app_mention'
      text = params["event"]["text"].gsub(/<@.*> /, '')
      workspace = Workspace.find_by(workspace_code: params[:team_id])
      Thread.new do
        Rails.cache.fetch("slack_message_#{params[:event][:client_msg_id]}", expires_in: 1.minute) do
          thread_ts = params["event"]["thread_ts"] || params["event"]["ts"]
          ChatThread.find_or_create_by(message_code: params[:event][:client_msg_id], role: :user) do |chat_thread|
            chat_thread.ts_code = thread_ts
            chat_thread.message = text
          end

          Slack.configure do |config|
            config.token = workspace.access_token
          end

          messages = ChatThread.where(ts_code: thread_ts).map { |chat_thread| { role: chat_thread.role.to_s, content: chat_thread.message } }
          text = OpenAiService.call(messages, workspace.open_ai_access_token)
          Slack::Web::Client.new.chat_postMessage(text: text,
                                                  thread_ts: params["event"]["ts"],
                                                  channel: params.dig("event","channel"),
                                                  as_user: true)

          ChatThread.find_or_create_by(message_code: params[:event][:client_msg_id], ts_code: thread_ts, message: text, role: :assistant)
        end
      end
      ''
    else
      ''
    end
  end
end
