# frozen_string_literal: true

class CrawlerJob < ApplicationJob
  def perform(ref)
    uri = URI.parse(ref.url)

    html = begin
             ferrum_get(uri)
           rescue => e
             nokogiri_parser(uri)
           end

    return if html.nil?

    doc = Nokogiri::HTML.parse(html, nil, 'utf-8')
    doc.css('script, style, noscript').each(&:remove)
    title = doc.xpath('//title').text
    body = doc.xpath('//body').text
      .gsub(/<[^>]*>/, '')
      .gsub(/\s/, '')
    ref.update(body:, title:)
  end

  private

  def nokogiri_parser(uri)
    response = Net::HTTP.get_response(uri)

    response.body if response.is_a?(Net::HTTPSuccess)
  rescue => e
    nil
  end

  def ferrum_get(uri)
    browser = Ferrum::Browser.new(timeout: 15, process_timeout: 60)
    browser.headers.set(
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
    )
    browser.go_to(uri)
    browser.network.wait_for_idle
    sleep 10
    html = browser.body
    browser.quit
    html
  end
end
