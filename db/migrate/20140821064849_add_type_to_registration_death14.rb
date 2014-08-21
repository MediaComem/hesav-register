class AddTypeToRegistrationDeath14 < ActiveRecord::Migration
  def change
  	add_column :death14_registrations, :registration_type, :hstore
  end
end
