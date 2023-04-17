class SlackAppMentionJob < ApplicationJob
  def perform(workspace, thread)
    urls = URI.extract(thread.message, ["http","https"])
    if urls.present?
      urls.each do |url|
        ref = thread.ref_urls.find_or_create_by(url: url)
        CrawlerJob.perform_now(ref)
      end
    end
    system_message = "あなたはSlackにインストールされてるチャットボットして振る舞ってください。現在時刻は#{Time.current.strftime('%Y年%m月%d日 %H時%M分%S秒')}です。"
    messages = [
      { role: :system, content: system_message }
    ]

    thread_messages = ChatThread.where(ts_code: thread.ts_code)
      .order(:created_at)
      .map { { role: _1.role.to_s, content: _1.message_with_ref_urls } }

    messages += thread_messages

    assistant_message = OpenAiService.call(messages, workspace.open_ai_access_token)
    if assistant_message
      response_thread = ChatThread.create(message_code: thread.message_code,
                                          role: :assistant,
                                          team_code: thread.team_code,
                                          channel_code: thread.channel_code,
                                          ts_code: thread.ts_code,
                                          message: assistant_message)

      SlackResponseJob.perform_later(workspace, response_thread)
    end
  end
end
