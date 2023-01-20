class OpenAiService
  def self.call(input)
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_ACCESS_TOKEN'])
    client.completions

    res = client.completions(
      parameters: {
        model: "text-davinci-003",
        prompt: input,
        max_tokens: 256,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0
      })
    res["choices"].map { |c| c["text"] }.join('')
  end
end
