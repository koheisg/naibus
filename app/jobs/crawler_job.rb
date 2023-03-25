class CrawlerJob < ApplicationJob
  def perform(ref)
    uri = URI.parse(ref.url)

    # html = net_http_get(uri)
    html = ferrum_get(uri)
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
  end

  def ferrum_get(uri)
    browser = Ferrum::Browser.new(timeout: 15, process_timeout: 60)
    browser.headers.set(
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
    )
    browser.go_to(uri)
    html = browser.body
    sleep 3
    browser.quit
    html
  end
end
