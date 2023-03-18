class OpenAiEmbeddingJob < ApplicationJob
  def perform(thread, workspace)
    split_long_sentences(thread.ref_urls.pluck(:body).join("\n"), 1000).each.with_index(1) do |message, i|
      embeding = OpenAiService.embeddings(message, workspace.open_ai_access_token)
      PineconeUpsertJob.perform_now(embeding, "#{thread.to_global_id}/#{i}")
    end
  end
end
