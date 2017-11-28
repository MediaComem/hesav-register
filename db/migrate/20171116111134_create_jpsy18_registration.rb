class CreateJpsy18Registration < ActiveRecord::Migration
  def change
    create_table :jpsy18_registrations do |t|
    	t.string :last_name
      t.string :first_name
      t.string :street
      t.integer :npa
      t.string :city
      t.string :email
      t.string :employer
      t.string :shopID
      t.string :environment
      t.string :language
      t.boolean :payed
      t.timestamps
      t.integer :event_id
      t.hstore :registration_type
    end
  end
end
