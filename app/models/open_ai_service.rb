class OpenAiService
  def self.chat_completions(messages, open_ai_access_token)
    client = OpenAI::Client.new(access_token: open_ai_access_token)
    client.completions

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: messages
      }
    )
    response.dig("choices", 0, "message", "content")
  end

  def self.embeddings(input, open_ai_access_token)
    client = OpenAI::Client.new(access_token: open_ai_access_token)
    response = client.embeddings(
      parameters: {
        model: "babbage-similarity",
        input: input
      }
    )

    response['data'][0]['embedding']
  end
end
