class OpenAiEmbeddingQueryJob < ApplicationJob
  def perform(query_message, thread, workspace)
    embeding = OpenAiService.embeddings(query_message, workspace.open_ai_access_token)
    response = query_pincone(embeding)
    original_messages = split_long_sentences(thread.ref_urls.pluck(:body).join("\n"), 1000)
    match_messages = response.dig('matches').map do
      original_messages[_1.dig('id').split('/').last.to_i - 1]
    end

    input = <<~EOS
      #{match_messages.join("\n")}

      #{query_message}
    EOS

    result = OpenAiService.chat_completions([{ role: 'user', content: input}], workspace.open_ai_access_token)

    pp result
  end

  private

  def query_pincone(embeding)
    Pinecone.new.query(
      {
        vector: embeding,
        includeValues: false,
        includeMetadata: false,
        topK: 1,
        namespace: ""
      }
    )
  end
end
