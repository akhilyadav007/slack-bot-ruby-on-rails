class AddAppsReferenceToIncident < ActiveRecord::Migration[7.0]
  def change
    add_reference :incidents, :app
  end
end
