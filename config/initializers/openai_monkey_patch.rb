unless OpenAI::VERSION == "3.4.0"
  raise "Consider removing this patch"
end

module NaibusHTTParty
  def json_post(path:, parameters:)
    HTTParty.post(
      uri(path: path),
      headers: headers,
      body: parameters&.to_json,
      timeout: 100000
    )
  end
end

OpenAI::Client.singleton_class.prepend(NaibusHTTParty)
