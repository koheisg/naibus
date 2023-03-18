class CrawlerJob < ApplicationJob
  def perform(ref)
    return if ref.body.present?

    uri = URI.parse(ref.url)
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      html = response.body
      doc = Nokogiri::HTML.parse(html, nil, 'utf-8')
      doc.css('script, style').each(&:remove)
      title = doc.xpath('//title').text
      body = doc.xpath('//body').text
        .gsub(/<[^>]*>/, '')
        .gsub(/\s/, '')
      ref.update(body: body, title: title)
    end
  end
end
