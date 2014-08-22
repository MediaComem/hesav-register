class CreateEtu14Registrations < ActiveRecord::Migration
  def change
    create_table :etu14_registrations do |t|
      t.string :title
      t.string :last_name
      t.string :first_name
      t.string :street
      t.integer :npa
      t.string :city
      t.string :country
      t.string :employer
      t.string :job
      t.string :email
      t.integer :price
      t.integer :registration_type
      t.boolean :assistance
      t.boolean :payed
      t.integer :event_id
      t.timestamps
    end
  end
end
