require 'rails_helper'

RSpec.describe SlackResponseJob, type: :job do
  describe '#perform' do
    let(:workspace) { create(:workspace) }
    let(:response_thread) { double('ResponseThread', message: 'Test message', ts_code: '12345', channel_code: 'C123456') }
    let(:slack_client) { instance_double(Slack::Web::Client) }

    before do
      allow(Slack::Web::Client).to receive(:new).and_return(slack_client)
    end

    specify do
      expect(slack_client).to receive(:chat_postMessage).with(text: 'Test message',
                                                              thread_ts: '12345',
                                                              channel: 'C123456',
                                                              as_user: true)
      described_class.new.perform(workspace, response_thread)
    end
  end
end
