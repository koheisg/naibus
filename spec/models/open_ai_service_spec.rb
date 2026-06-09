
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenAiService, type: :model do
  describe '.call' do
    subject { described_class.call(messages: messages, access_token: access_token, model: model) }

    let(:messages) { [{ role: 'user', content: 'Hello!' }] }
    let(:access_token) { 'test_access_token' }
    let(:model) { 'gpt-5-nano' }
    let(:mock_response) do
      {
        'output' => [
          { 'type' => 'web_search_call', 'status' => 'completed' },
          { 'type' => 'message', 'role' => 'assistant',
            'content' => [{ 'type' => 'output_text', 'text' => 'Hi there!' }] }
        ]
      }
    end
    let(:responses) { instance_double(OpenAI::Responses, create: mock_response) }
    let(:openai_client) { instance_double(OpenAI::Client, responses: responses) }

    before { allow(OpenAI::Client).to receive(:new).and_return(openai_client) }

    it { is_expected.to eq('Hi there!') }
  end
end
