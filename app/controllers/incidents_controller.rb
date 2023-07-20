class IncidentsController < ApplicationController
  
  before_action :fetch_app, :check_incident_validity, only: :investigate_incident

  def index
    @incidents = Incident.all
  end

  def investigate_incident
    command = params[:text].split(" ").first
  
    case command
    when "declare"
      create_new_incident(params, @current_app.id)
    when "resolve"
      resolve_incident(params)
    else
      render json: { "response_type": "ephemeral", "text": "Invalid command" }
    end
  rescue => e
    render json: { "response_type": "ephemeral", "text": e.message }
  end

  def sort_incident_list
    incidents = Incident.includes(:reporter).order("#{params[:column]} #{params[:direction]}")
    render partial: 'incidents', locals:{ incidents: incidents }
  end
  
  private

    def incident_details_params
      params.require(:incident).permit(:title, :description, :severity, :status)
    end

    def check_incident_validity
      command, title = params[:text].split(" ", 2)
    
      case command
      when "declare"
        validate_declaration(title)
      when "resolve"
        validate_resolution
      end
    end
    
    def validate_declaration(title)
      channel = Channel.find_by(name: title)
      if channel.present?
        channel_url = "https://#{params['team_domain']}.slack.com/archives/#{channel.slack_id}"
        render json: invalid_incident_response(channel_url, channel.name) and return
      end
    end
    
    def validate_resolution
      channel = Channel.find_by(slack_id: params[:channel_id])
      render json: invalid_channel_response and return unless channel.present?
    
      if channel.incident&.resolved?
        render json: { "success": true, message: "Incident has already been resolved." } and return
      end
    end
    
    def fetch_app
      user_id = params[:user_id]
      @current_app ||= App.find_or_initialize_by(auth_user_id: user_id)
    end
end
