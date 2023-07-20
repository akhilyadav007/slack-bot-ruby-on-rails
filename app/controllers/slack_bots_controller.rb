class SlackBotsController < ApplicationController

  def slack_auth
    code = params[:code]
    url = 'https://slack.com/api/oauth.v2.access'
    res = RestClient.post(url, auth_payload ,headers = { 'Content-Type' => 'application/json' })
    response = JSON.parse(res.body)

    if response["ok"]
      create_app(response)
      redirect_to "https://slack.com/app_redirect?team=#{response['team']['id']}&app=#{response['app_id']}", allow_other_host: true
    end
  end
  
  private

  def auth_payload
    {
      client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      grant_type: "authorization_code",
      redirect_uri: "https://#{ENV['HOST_URL']}#{ENV['REDIRECT_URI']}",
      code: params["code"]
    }
  end
    
  def create_app(response)
    App.where(slack_id: response["app_id"], 
          auth_user_id: response["authed_user"]["id"],
          scope: response["scope"],
          access_token: response["access_token"],
          team_id: response["team"]["id"],
          team_name: response["team"]["name"]
      ).first_or_create
  end
end
