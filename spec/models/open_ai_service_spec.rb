
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenAiService, type: :model do
  describe '.call' do
    subject { described_class.call(messages: messages, access_token: access_token, model: model) }

    let(:messages) { [{ role: 'user', content: 'Hello!' }] }
    let(:access_token) { 'test_access_token' }
    let(:model) { 'gpt-3.5-turbo' }
    let(:mock_response) do
      {
        'choices' => [
          { 'message' => { 'content' => 'Hi there!' } }
        ]
      }
    end
    let(:openai_client) { instance_double(OpenAI::Client, chat: mock_response, completions: nil) }

    before { allow(OpenAI::Client).to receive(:new).and_return(openai_client) }

    it { is_expected.to eq('Hi there!') }
  end
end
