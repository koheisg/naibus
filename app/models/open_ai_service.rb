# frozen_string_literal: true

class OpenAiService
  # Models that support the built-in web_search tool (nano tiers don't).
  WEB_SEARCH_MODELS = %w[gpt-5 gpt-5-mini gpt-4.1 gpt-4.1-mini gpt-4o].freeze

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
        tools: web_search_tools(model)
      }.compact
    )

    extract_text(response)
  end

  def self.web_search_tools(model)
    [{ type: 'web_search' }] if WEB_SEARCH_MODELS.include?(model)
  end

  def self.extract_text(response)
    response['output']
      &.find { _1['type'] == 'message' }
      &.dig('content')
      &.find { _1['type'] == 'output_text' }
      &.dig('text')
  end
end
