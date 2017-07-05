class CreatePsy17Registration < ActiveRecord::Migration
  def change
    create_table :psy17_registrations do |t|
    	t.string :last_name
      t.string :first_name
      t.string :street
      t.integer :streetnumber
      t.integer :npa
      t.string :city
      t.string :email
      t.string :employer
      t.string :job
      t.string :shopID
      t.string :environment
      t.string :language
      t.boolean :payed
      t.timestamps
      t.string :event_id
      t.hstore :registration_type
    end
  end
end
