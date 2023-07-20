class AddUserReferenceToIncident < ActiveRecord::Migration[7.0]
  def change
    add_reference :incidents, :reporter, references: :users, foreign_key: { to_table: :users }
    add_reference :incidents, :resolver, references: :users, foreign_key: { to_table: :users }
  end
end
