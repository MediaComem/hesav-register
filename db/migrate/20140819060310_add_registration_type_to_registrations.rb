class AddRegistrationTypeToRegistrations < ActiveRecord::Migration
  def change
    add_column :psy14_registrations, :registration_type, :hstore
  end
end
