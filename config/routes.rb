Rails.application.routes.draw do
  get 'slack_bots/slack_auth'
  post 'incidents/investigate_incident'
  get 'incidents/index' 
  get 'incidents/sort_incident_list'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "incidents#index" 
end
