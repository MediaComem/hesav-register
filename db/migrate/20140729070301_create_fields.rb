class CreateFields < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :name
      t.string :value

      t.integer :registration_id
    end
  end
end
