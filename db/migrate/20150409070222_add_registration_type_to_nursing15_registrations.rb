class AddRegistrationTypeToNursing15Registrations < ActiveRecord::Migration
  def change
    add_column :nursing15_registrations, :registration_type, :hstore
  end
end
