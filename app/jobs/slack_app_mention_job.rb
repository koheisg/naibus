# frozen_string_literal: true

class SlackAppMentionJob < ApplicationJob
  def perform(workspace, thread)
    urls = URI.extract(thread.message, %w[http https])
    if urls.present?
      urls.each do |url|
        ref = thread.ref_urls.find_or_create_by(url:)
        CrawlerJob.perform_now(ref)
      end
    end
    system_message = workspace.system_message || default_system_message
    messages = [
      { role: :system,
        content: format(system_message, current_time:) }
    ]

    thread_messages = ChatThread.where(ts_code: thread.ts_code)
                                .order(:created_at)
                                .map { { role: _1.role.to_s, content: _1.message_with_ref_urls } }

    messages += thread_messages

    assistant_message = generate_assistant_message(workspace, messages)

    return unless assistant_message

    response_thread = ChatThread.create(message_code: thread.message_code,
                                        role: :assistant,
                                        team_code: thread.team_code,
                                        channel_code: thread.channel_code,
                                        ts_code: thread.ts_code,
                                        message: assistant_message)

    SlackResponseJob.perform_later(workspace, response_thread)
  end

  private

  def generate_assistant_message(workspace, messages)
    access_token = workspace.open_ai_access_token
    model = workspace.open_ai_model
    OpenAiService.call(messages:, access_token:, model:)
  end

  def current_time
    Time.current.in_time_zone('Tokyo').strftime('%Y年%m月%d日 %H時%M分%S秒')
  end

  def default_system_message
    <<~TEXT
    あなたはSlackにインストールされてるチャットボットして振る舞ってください。
    現在時刻は#{current_time}です。
    TEXT
  end
end
