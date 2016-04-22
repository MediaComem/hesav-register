class CreatePsy16Registration < ActiveRecord::Migration
  def change
    create_table :psy16_registrations do |t|
			t.string :title
      t.string :last_name
      t.string :first_name
      t.string :street
      t.integer :npa
      t.string :city
      t.string :country
      t.string :email
      t.string :shopID
      t.string :environment
      t.string :language
      t.string :job
      t.string :employer
      t.boolean :payed
      t.timestamps
      t.integer :event_id
      t.hstore :registration_type
    end
  end
end
