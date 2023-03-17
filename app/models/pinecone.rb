require 'httparty'

class Pinecone
  INDEX_NAME = 'naibus'
  PROJECT_ID = '6f7fc84'
  ENVIRONMENT = 'us-east-1-aws'

  def initialize
    @base_url = "https://#{INDEX_NAME}-#{PROJECT_ID}.svc.#{ENVIRONMENT}.pinecone.io"
    @controller_url = "https://controller.#{ENVIRONMENT}.pinecone.io"
    @headers = {
      "accept": "application/json",
      "content-type": "application/json",
      "Api-Key": ENV['PINECONE_API_KEY']
    }
  end

  def describe_index_stats
    url = "#{@base_url}/describe_index_stats"
    HTTParty.post(url, headers: @headers, verify: true)
  end

  def query(body)
    url = "#{@base_url}/query"
    HTTParty.post(url, headers: @headers, body: body.to_json, verify: true)
  end

  def delete_vectors(delete_all = false)
    url = "#{@base_url}/vectors/delete"
    body = { "deleteAll": delete_all.to_s }.to_json
    HTTParty.post(url, headers: @headers, body: body, verify: true)
  end

  def fetch_vectors
    url = "#{@base_url}/vectors/fetch"
    HTTParty.get(url, headers: @headers, verify: true)
  end

  def update_vectors
    url = "#{@base_url}/vectors/update"
    HTTParty.post(url, headers: @headers, verify: true)
  end

  def upsert_vectors(body)
    url = "#{@base_url}/vectors/upsert"
    HTTParty.post(url, headers: @headers, verify: true, body: body)
  end

  def list_collections
    url = "#{@controller_url}/collections"
    headers = { "accept": "application/json; charset=utf-8" }
    HTTParty.get(url, headers: headers, verify: true)
  end

  def create_collection
    url = "#{@controller_url}/collections"
    headers = { "accept": "text/plain", "content-type": "application/json" }
    HTTParty.post(url, headers: headers, verify: true)
  end

  def get_collection(collection_name)
    url = "#{@controller_url}/collections/#{collection_name}"
    headers = { "accept": "application/json" }
    HTTParty.get(url, headers: headers, verify: true)
  end

  def delete_collection(collection_name)
    url = "#{@controller_url}/collections/#{collection_name}"
    headers = { "accept": "text/plain" }
    HTTParty.delete(url, headers: headers, verify: true)
  end

  def list_databases
    url = "#{@controller_url}/databases"
    headers = { "accept": "application/json; charset=utf-8" }
    HTTParty.get(url, headers: headers, verify: true)
  end

  def create_database(index_name, metric, pods, replicas, pod_type)
    url = "#{@controller_url}/databases"
    headers = { "accept": "text/plain", "content-type": "application/json" }
    body = {
      "index_name": index_name,
      "metric": metric,
      "pods": pods,
      "replicas": replicas,
      "pod_type": pod_type
    }.to_json
    HTTParty.post(url, headers: headers, body: body, verify: true)
  end

  def get_database(index_name)
    url = "#{@controller_url}/databases/#{index_name}"
    headers = { "accept": "application/json" }
    HTTParty.get(url, headers: headers, verify: true)
  end

  def delete_database(index_name)
    url = "#{@controller_url}/databases/#{index_name}"
    headers = { "accept": "text/plain" }
    HTTParty.delete(url, headers: headers, verify: true)
  end

  def update_database(index_name, metric, pods, replicas, pod_type)
    url = "#{@controller_url}/databases/#{index_name}"
    headers = { "accept": "text/plain", "content-type": "application/json" }
    body = {
      "metric": metric,
      "pods": pods,
      "replicas": replicas,
      "pod_type": pod_type
    }.to_json
    HTTParty.patch(url, headers: headers, body: body, verify: true)
  end
end
