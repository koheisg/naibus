require 'rails_helper'

RSpec.describe Pinecone do
  let(:pinecone) { Pinecone.new("index_name", "project_id", "environment") }

  describe "#describe_index_stats" do
    it "returns a successful response" do
      response = pinecone.describe_index_stats
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json")
    end
  end

  describe "#query" do
    it "returns a successful response" do
      response = pinecone.query(false, false)
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json")
    end
  end

  describe "#delete_vectors" do
    it "returns a successful response" do
      response = pinecone.delete_vectors(false)
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json")
    end
  end

  describe "#fetch_vectors" do
    it "returns a successful response" do
      response = pinecone.fetch_vectors
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json")
    end
  end

  describe "#update_vectors" do
    it "returns a successful response" do
      response = pinecone.update_vectors
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json")
    end
  end

  describe "#upsert_vectors" do
    it "returns a successful response" do
      response = pinecone.upsert_vectors
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json")
    end
  end

  describe "#list_collections" do
    it "returns a successful response" do
      response = pinecone.list_collections
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json; charset=utf-8")
    end
  end

  describe "#create_collection" do
    it "returns a successful response" do
      response = pinecone.create_collection
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("text/plain")
    end
  end

  describe "#get_collection" do
    it "returns a successful response" do
      response = pinecone.get_collection("collection_name")
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json")
    end
  end

  describe "#delete_collection" do
    it "returns a successful response" do
      response = pinecone.delete_collection("collection_name")
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("text/plain")
    end
  end

  describe "#list_databases" do
    it "returns a successful response" do
      response = pinecone.list_databases
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json; charset=utf-8")
    end
  end

  describe "#create_database" do
    it "returns a successful response" do
      response = pinecone.create_database("index_name", "cosine", 1, 1, "p1.x1")
      expect(response.code).to eq(200)
      expect(response.body).to include("Database created successfully")
    end
  end

  describe "#get_database" do
    it "returns a successful response" do
      response = pinecone.get_database("index_name")
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("application/json")
    end
  end

  describe "#delete_database" do
    it "returns a successful response" do
      response = pinecone.delete_database("index_name")
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("text/plain")
    end
  end

  describe "#update_database" do
    it "returns a successful response" do
      response = pinecone.update_database("index_name", "cosine", 1, 1, "p1.x1")
      expect(response.code).to eq(200)
      expect(response.headers["content-type"]).to eq("text/plain")
      expect(response.body).to include("Database updated successfully")
    end
  end
end
