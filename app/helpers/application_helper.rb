module ApplicationHelper
  def build_app_url
    "https://slack.com/oauth/v2/authorize?client_id=#{ENV['CLIENT_ID']}&scope=#{ENV['PERMISSION_SCOPE']}&redirect_uri=https://#{ENV['HOST_URL']}"+"#{ENV['REDIRECT_URI']}"
  end

  def build_sort_link(column:, label:)
    if column == params[:column]
      link_to(label, incidents_sort_incident_list_path(column: column, direction: short_next))
    else
      link_to(label, incidents_sort_incident_list_path(column: column, direction: 'asc'))
    end 
  end
  
  def short_next
    params[:direction] == 'asc' ? 'desc' : 'asc'
  end
end 
