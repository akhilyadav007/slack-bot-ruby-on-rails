class CreateApps < ActiveRecord::Migration[7.0]
  def change
    create_table :apps do |t|
      t.string :slack_id
      t.string :auth_user_id
      t.string :scope
      t.string :access_token
      t.string :team_id
      t.string :team_name
      
      t.timestamps
    end
  end
end
