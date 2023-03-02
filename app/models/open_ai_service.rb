class OpenAiService
  def self.call(input)
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_ACCESS_TOKEN'])
    client.completions

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: input}],
      })
    response.dig("choices", 0, "message", "content")
  end
end
