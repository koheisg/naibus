require 'rails_helper'

RSpec.describe CrawlerJob, type: :job do
  describe '#perform' do
    subject { described_class.perform_now(ref) }

    context 'when ref is valid' do
      let(:ref) { create(:ref_url, url: 'https://example.com') }

      specify do
        expect(Net::HTTP).to receive(:get_response).and_return(
          instance_double(Net::HTTPSuccess, is_a?: true, body: <<~HTML)
          <html>
          <head><title>Example</title></head>
          <body>
          <script>console.log('a')</script>
          <div><h1>Example</h1></div>
          </body>
          </html>
          HTML
        )

        subject
        expect(ref.reload.title).to eq('Example')
        expect(ref.reload.body).to eq('Example')
      end
    end
  end
end
