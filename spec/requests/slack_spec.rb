require 'rails_helper'

RSpec.describe 'Slack' do
  describe 'POST /slack/endpoint' do
    context 'when params["event"]["type"] == "url_verification"' do
      it 'returns 200' do
        post '/slack/endpoint', params: { challenge: 'challenge', event: { type: 'url_verification' } }
        expect(response).to have_http_status(200)
        expect(response.body).to eq({ challenge: 'challenge' }.to_json)
      end
    end

    context 'when params["event"]["type"] == "app_mention"' do
      it 'returns 404' do
        expect {
          post '/slack/endpoint', params: { event: { type: 'app_mention', team_id: 'xxxxx' } }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when params["event"]["type"] = "app_mention"' do
      before do
        create(:workspace, workspace_code: 'xxxxx')
      end

      it 'returns 200' do
        expect {
          post '/slack/endpoint', params: { event: { type: 'app_mention', text: '@naibus foo bar' }, team_id: 'xxxxx' }
        }.to change(ChatThread, :count).by(1)
          .and have_enqueued_job(SlackAppMentionJob)
        expect(response).to have_http_status(200)
        expect(response.body).to eq('')
      end
    end

    context 'when params["event"]["type"] = "app_mention"' do
      before do
        create(:workspace, workspace_code: 'xxxxx')
      end

      it 'returns 200' do
        expect {
          post '/slack/endpoint', params: { event: { type: 'app_mention', text: '@naibus foo bar http://example.com' }, team_id: 'xxxxx' }
        }.to change(ChatThread, :count).by(1)
          .and have_enqueued_job(SlackAppMentionWithUrlJob)
        expect(response).to have_http_status(200)
        expect(response.body).to eq('')
      end
    end
  end

  xdescribe 'GET /slack/auth_callback' do
    context 'when params[:error]' do
      it 'redirects to root_path' do
        get '/slack/auth_callback', params: { error: 'error' }
        expect(response).to redirect_to(root_path)
        expect(response.body).to eq ''
      end
    end

    context 'when !params[:error]' do
      it 'redirects to edit_workspace_path' do
        get '/slack/auth_callback', params: { code: 'code' }
        expect(response).to redirect_to(edit_workspace_path)
        expect(response.body).to eq ''
      end
    end
  end
end
