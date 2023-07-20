module SlackBotsResponses
  extend ActiveSupport::Concern

  def open_success_response(channel_url,channel_name)
    main_text = "Incident *#{channel_name}* has been logged:"
    sub_text = "you can track the status on channel *#{channel_name}*"

    incident_success_response(main_text,sub_text,channel_url) 
  end

  def resolve_incident_response(resolved_in, channel_name)
    { "attachments": [ { "blocks": [ { "type": "section", "text": { "type": "mrkdwn", "text": "Incident *#{channel_name}* has been resolved" } }, { "type": "divider" },{ "type": "section", "text": { "type": "mrkdwn","text": "Time to resolve: *#{resolved_in}* minutes" } } ] } ] }
  end

  def invalid_channel_response
    { "attachments": [ { "blocks": [ { "type": "section", "text": { "type": "mrkdwn", "text": "\n \n Invalid channel" } }, { "type": "divider" }, { "type": "section", "text": { "type": "mrkdwn", "text": "we don't have an incident logged with this channel_name" } } ] } ] }
  end

  def invalid_incident_response(channel_url,channel_name)
    main_text = "Incident *#{channel_name}* has already been logged:"
    sub_text = "you can track the status on channel *#{channel_name}*"

    incident_success_response(main_text,sub_text,channel_url)
  end

  def incident_success_response(main_text,sub_text,channel_url)
    { "attachments": [ { "blocks": [ { "type": "section", "text": { "type": "mrkdwn", "text": main_text } }, { "type": "divider" }, { "type": "section", "text": { "type": "mrkdwn", "text": sub_text } }, { "type": "actions", "elements": [ { "type": "button", "text": { "type": "plain_text", "text": "View channel" }, "value": "click_me", "url": channel_url } ] } ] } ] }
  end
end