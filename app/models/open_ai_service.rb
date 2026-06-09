# frozen_string_literal: true

class OpenAiService
  def self.call(messages:, access_token:, model: 'gpt-5-nano')
    client = OpenAI::Client.new(access_token:, request_timeout: 100_000)

    system_message = messages.find { _1[:role].to_s == 'system' }
    input = messages.reject { _1[:role].to_s == 'system' }
                    .map { { role: _1[:role].to_s, content: _1[:content] } }

    response = client.responses.create(
      parameters: {
        model:,
        instructions: system_message&.fetch(:content, nil),
        input:,
        tools: [{ type: 'web_search' }]
      }.compact
    )

    extract_text(response)
  end

  def self.extract_text(response)
    response['output']
      &.find { _1['type'] == 'message' }
      &.dig('content')
      &.find { _1['type'] == 'output_text' }
      &.dig('text')
  end
end
