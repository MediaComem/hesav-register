class AddColumnStreetNumberToAuto17 < ActiveRecord::Migration
  def change
  	add_column :auto17_registrations, :streetnumber, :integer
  end
end
