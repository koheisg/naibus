class OpenAiService
  def self.call(messages, open_ai_access_token)
    client = OpenAI::Client.new(access_token: open_ai_access_token)
    client.completions

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: messages
      })
    response.dig("choices", 0, "message", "content")
  end
end
