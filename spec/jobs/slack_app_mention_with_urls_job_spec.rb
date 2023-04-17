# frozen_string_literal: true

require 'rails_helper'

describe SlackAppMentionWithUrlsJob do
  describe 'perform' do
    subject { described_class.perform_now(create(:workspace), create(:chat_thread), ['https://www.example.com']) }

    before do
      allow(OpenAiService).to receive(:call).and_return(
        'foo bar'
      )
    end

    specify do
      expect { subject }.to change(ChatThread.assistant, :count).by(1)
    end
  end
end
