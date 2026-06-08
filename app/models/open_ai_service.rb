# frozen_string_literal: true

class OpenAiService
  def self.call(messages:, access_token:, model: 'gpt-5-nano')
    client = OpenAI::Client.new(access_token:, request_timeout: 100_000)
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
