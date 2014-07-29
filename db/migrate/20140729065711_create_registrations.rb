class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :last_name
      t.string :first_name
      t.string :registration_type
      t.integer :paid
      
      t.timestamps

      t.integer :event_id
    end
  end
end
