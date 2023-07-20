class CreateIncidents < ActiveRecord::Migration[7.0]
  def change
    create_table :incidents do |t|
      t.string :title
      t.text :description
      t.integer :severity
      t.integer :status, default: 0
      t.string  :webhook_url
      
      t.timestamps
    end
  end
end
