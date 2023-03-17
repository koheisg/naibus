class PineconeUpsertJob < ApplicationJob
  def perform(input, pincone_id)
    Pinecone.new.upsert_vectors(
      {
        vectors: [
          {
            id: pincone_id,
            values: input
          }
        ]
      }.to_json
    )
  end
end
