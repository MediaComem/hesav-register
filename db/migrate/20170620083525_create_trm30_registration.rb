class CreateTrm30Registration < ActiveRecord::Migration
  def change
    create_table :trm30_registrations do |t|
    	t.string :last_name
      t.string :first_name
      t.string :street
      t.string :streetnumber
      t.integer :npa
      t.string :city
      t.string :email
      t.string :employer
      t.string :environment
      t.string :language
      t.timestamps
      t.integer :event_id
    end
  end
end
