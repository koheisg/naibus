class SlackResponseJob < ApplicationJob
  def perform(workspace, response_thread)
    Slack.configure do |config|
      config.token = workspace.access_token
    end
    Slack::Web::Client.new.chat_postMessage(text: response_thread.message,
                                            thread_ts: response_thread.ts_code,
                                            channel: response_thread.channel_code,
                                            as_user: true)
  end
end
