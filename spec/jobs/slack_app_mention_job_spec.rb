# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SlackAppMentionJob do
  describe '#perform' do
    subject do
      described_class.perform_now(create(:workspace), chat_thread)
    end

    let(:chat_thread) { create(:chat_thread, :user) }

    before { allow(OpenAiService).to receive(:call).and_return('foo bar') }

    specify do
      expect { subject }.to change(ChatThread.assistant, :count).by(1)
                        .and have_enqueued_job(SlackResponseJob)
    end
  end
end
