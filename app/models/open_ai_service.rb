# frozen_string_literal: true

class OpenAiService
  def self.call(messages, open_ai_access_token, model: 'gpt-3.5-turbo')
    client = OpenAI::Client.new(access_token: open_ai_access_token, request_timeout: 100_000)
    client.completions

    response = client.chat(
      parameters: {
        model:,
        messages:
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end
end
