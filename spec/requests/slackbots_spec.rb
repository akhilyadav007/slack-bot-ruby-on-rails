require 'rails_helper'

RSpec.describe SlackBotsController, type: :controller do
  describe 'POST #slack_auth' do
    let(:code) { 'sample_code' }
    let(:response_body) do
      {
        "ok" => true,
        "app_id" => "sample_app_id",
        "authed_user" => { "id" => "sample_user_id" },
        "scope" => "sample_scope",
        "access_token" => "sample_access_token",
        "team" => { "id" => "sample_team_id", "name" => "sample_team_name" }
      }.to_json
    end

    before do
      allow(RestClient).to receive(:post).and_return(double(body: response_body))
    end

    it 'creates an app and redirects successfully' do
      expect(App).to receive(:where).with(
        slack_id: "sample_app_id",
        auth_user_id: "sample_user_id",
        scope: "sample_scope",
        access_token: "sample_access_token",
        team_id: "sample_team_id",
        team_name: "sample_team_name"
      ).and_return(App)

      post :slack_auth, params: { code: code }

      expect(response).to redirect_to("https://slack.com/app_redirect?team=sample_team_id&app=sample_app_id")
      expect(response).to have_http_status(:found)
    end

    it 'does not create an app if response is not OK' do
      response_body = { "ok" => false }.to_json
      allow(RestClient).to receive(:post).and_return(double(body: response_body))

      expect(App).not_to receive(:where)

      post :slack_auth, params: { code: code }

      expect(response).to have_http_status(:no_content)
    end
  end
end
