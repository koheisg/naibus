class SlackAppMentionJob < ApplicationJob
  def perform(workspace, thread)
    urls = URI.extract(thread.message, ["http","https"])
    urls.each do |url|
      ref = thread.ref_urls.create(url: url)
      CrawlerJob.perform_now(ref)
    end

    messages = ChatThread.where(ts_code: thread.ts_code).map do |chat_thread|
      { role: chat_thread.role.to_s, content: chat_thread.message_with_ref_urls }
    end
    assistant_message = OpenAiService.call(messages, workspace.open_ai_access_token)

    response_thread = ChatThread.create(message_code: thread.message_code,
                                        role: :assistant,
                                        team_code: thread.team_code,
                                        channel_code: thread.channel_code,
                                        ts_code: thread.ts_code,
                                        message: assistant_message)

    SlackResponseJob.perform_later(workspace, response_thread)
  end
end
