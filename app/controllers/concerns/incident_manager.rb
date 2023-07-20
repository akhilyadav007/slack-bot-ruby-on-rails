module IncidentManager
  extend ActiveSupport::Concern 

  def create_new_incident(params,app_id)
    title = params[:text].split(" ")[1]
    incident = create_incident(app_id)
    channel_id, channel_name = SlackChannel.call(incident, params[:team_id])
    channel_url = "https://#{params['team_domain']}.slack.com/archives/#{channel_id}"

    res = RestClient.post(incident.webhook_url, open_success_response(channel_url,channel_name).to_json ,
    headers = { 'Content-Type' => 'application/json', :Authorization => "Bearer #{incident.app.access_token}" }
    )
  end 

  def create_incident(app_id)
    action, title, description, severity = params[:text].split(" ")
    response_url = params[:response_url]

    reporter = create_user

    reporter.reported_incidents.create(
      title: title,
      description: description,
      severity: severity,
      webhook_url: response_url,
      app_id: app_id
    )
  end 

  def create_user
    User.where(slack_id: params[:user_id], name: params[:user_name]).first_or_create
  end

  def resolve_incident(params)
    channel = Channel.find_by(slack_id: params[:channel_id])
    resolver = create_user
    incident = channel.incident
    resolved_in, channel_name = incident.resolution_time, channel.name 

    res = RestClient.post(params[:response_url], resolve_incident_response(resolved_in, channel_name).to_json ,
    headers = { 'Content-Type' => 'application/json', :Authorization => "Bearer #{incident.app.access_token}" }
    )
    incident.update(status: :resolved, resolver_id: resolver.id)
  end
end

