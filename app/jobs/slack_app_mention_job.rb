class SlackAppMentionJob < ApplicationJob
  def perform(workspace, thread)
    messages = ChatThread.where(ts_code: thread.ts_code).map { |chat_thread| { role: chat_thread.role.to_s, content: chat_thread.message } }
    assistant_message = OpenAiService.call(messages, workspace.open_ai_access_token)

    response_thread = ChatThread.create!(message_code: thread.code,
                                         team_id: thread.team_id,
                                         channel: thread.channel,
                                         ts_code: thread.ts_code,
                                         message: assistant_message,
                                         role: :assistant)

    SlackResponseJob.perform_later(workspace, response_thread)
  end
end
