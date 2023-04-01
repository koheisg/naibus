class ChatThread < ApplicationRecord
  has_many :ref_urls

  enum role: { user: 0, assistant: 1 }

  def message_with_ref_urls
    if ref_urls.any?
      ref_messages = ref_urls.map do |ref_url|
        <<~EOS
          ----
          #{ref_url.title} には以下の記載があります
          body: #{ref_url.body.gsub(/\s/, '')[..1000]}
        EOS
      end

      <<~EOS
        #{message} (現在時刻:#{created_at})

        #{ref_messages.join('\n')}
      EOS
    else
      "#{message} (現在時刻:#{created_at})"
    end
  end
end
