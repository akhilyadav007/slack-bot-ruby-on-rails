# frozen_string_literal: true

class SlackChannel < ApplicationService
  def initialize(incident, team_id)
    @title = incident.title
    @team_id = team_id
    @incident_id = incident.id
    @access_token = incident&.app&.access_token || @current_app.access_token
  end

  def call
    url = 'https://slack.com/api/conversations.create'
    res = RestClient.post(url, { name: @title, team_id: @team_id },
                          headers = { 'Content-Type' => 'application/json', :Authorization => "Bearer #{@access_token}" })
    response = JSON.parse(res.body)
    if response["channel"].present? && response["channel"]["id"].present?
      create_channel(response["channel"].slice('id','name','creator','context_team_id')) if response["ok"]
      join_channel(response["channel"]["id"])
      return response["channel"]["id"], response["channel"]["name"]
    end
    raise response["error"]  unless response["ok"]
  end

  def create_channel(opt={})
    slack_id = opt['id']
    name = opt['name']
    incident_id = @incident_id
    team_id = opt['context_team_id']
    Channel.create(slack_id: slack_id, name: name, incident_id: incident_id, team_id: team_id)
  end

  def join_channel(channel_id)
    url = 'https://slack.com/api/conversations.join'
    res = RestClient.post(url, { channel: channel_id },
                          headers = { 'Content-Type' => 'application/json', :Authorization => "Bearer #{@access_token}" })
  end
end
