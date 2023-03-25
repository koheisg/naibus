class SlackRetriveConversationJob < ApplicationJob
  def perform(workspace, channel_code, ts)
    Slack.configure do |config|
      config.token = workspace.access_token
    end

    item = Slack::Web::Client.new.conversations_history(channel: channel_code,
                                                        ts: ts,
                                                        inclusive: true,
                                                        limit: 1)

    return if !item['ok']

    message_item = item['messages'][0]

    thread = ChatTread.find_by(workspace_id: workspace.id, ts: ts)

    if thread.blank?
      thread = ChatThread.new(message_code: message_item[:client_msg_id],
                              role: :user,
                              team_code: workspace.workspace_code,
                              channel_code: channel_code,
                              ts_code: ts,
                              message: message_item["text"].gsub(/<@.*?> /, ''))
      thread.save
    end


    SlackAppMentionJob.perform_later(workspace, thread)
  end
end
