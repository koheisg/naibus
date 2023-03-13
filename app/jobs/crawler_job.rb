class CrawlerJob < ApplicationJob
  def perform(ref)
    uri = URI.parse(ref.url)
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      html = response.body
      doc = Nokogiri::HTML.parse(html, nil, 'utf-8')
      title = doc.xpath('//title')
      body = doc.xpath('//body').text.gsub(/<[^>]*>/, '')
      ref.update(body: body, title: title)
    end
  end
end
