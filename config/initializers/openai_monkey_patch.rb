# frozen_string_literal: true

raise 'Consider removing this patch' unless OpenAI::VERSION == '3.4.0'

module NaibusHTTParty
  def json_post(path:, parameters:)
    HTTParty.post(
      uri(path:),
      headers:,
      body: parameters&.to_json,
      timeout: 100_000
    )
  end
end

OpenAI::Client.singleton_class.prepend(NaibusHTTParty)
