# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Slack' do
  describe 'POST /slack/endpoint' do
    subject(:post_request) { post '/slack/endpoint', params: params }

    context 'when params["event"]["type"] == "url_verification"' do
      let(:params) { { challenge: 'challenge', event: { type: 'url_verification' } } }

      it 'returns 200' do
        post_request
        expect(response).to have_http_status(200)
        expect(response.body).to eq({ challenge: 'challenge' }.to_json)
      end
    end

    context 'when params["event"]["type"] == "app_mention"' do
      let(:params) { { event: { type: 'app_mention', text: '@naibus foo bar' }, team_id: 'xxxxx' } }

      it 'returns 404' do
        expect { post_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when params["event"]["type"] = "app_mention"' do
      let(:params) {  { event: { type: 'app_mention', text: '@naibus foo bar' }, team_id: 'xxxxx' } }

      before do
        create(:workspace, workspace_code: 'xxxxx')
      end

      it 'returns 200' do
        expect { post_request }.to change(ChatThread, :count).by(1)
                                         .and have_enqueued_job(SlackAppMentionJob)
        expect(response).to have_http_status(200)
        expect(response.body).to eq('')
      end
    end

    context 'when params["event"]["type"] = "reaction_added" && params["event"]["reaction"] == "naibus"' do
      let(:params) do
        { event: { type: 'reaction_added',
                   reaction: 'naibus',
                   item: { channel: 'channel_code', ts: 'ts_code' } },
          authorizations: [{ team_id: 'xxxxx' }] }
      end
      before do
        create(:workspace, workspace_code: 'xxxxx')
      end

      it 'returns 200' do
        expect { post_request }.to have_enqueued_job(SlackRetriveConversationJob)
        expect(response).to have_http_status(200)
        expect(response.body).to eq('')
      end
    end
  end

  describe 'GET /slack/auth/callback' do
    context 'when params[:error]' do
      it 'redirects to root_path' do
        get '/slack/auth/callback', params: { error: 'error' }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when !params[:error]' do
      let(:client) { instance_double(Slack::Web::Client) }
      let(:res) do
        {
          'ok' => true,
          'access_token' => 'access_token',
          'team' => { 'id' => 'workspace_id' },
          'authed_user' => { 'id' => 'user_id' }
        }
      end
      before do
        allow(Slack::Web::Client).to receive(:new).and_return(client)
        allow(client).to receive(:oauth_v2_access).and_return(res)
      end
      it 'redirects to edit_workspace_path' do
        get '/slack/auth/callback', params: { code: 'code' }
        expect(response).to redirect_to(edit_workspace_path)
      end
    end
  end
end
