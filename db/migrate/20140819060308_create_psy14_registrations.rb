class CreatePsy14Registrations < ActiveRecord::Migration
  def change
    create_table :psy14_registrations do |t|
      t.string :last_name
      t.string :first_name
      t.string :street
      t.integer :npa
      t.string :city
      t.string :email
      t.string :shopID
      t.string :environment
      t.string :language
      t.string :job
      t.string :employer
      t.boolean :payed

      t.timestamps
      t.integer :event_id
    end
  end
end