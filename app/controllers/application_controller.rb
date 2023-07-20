class ApplicationController < ActionController::Base
  include IncidentManager 
  include SlackBotsResponses
  protect_from_forgery with: :null_session 
end
