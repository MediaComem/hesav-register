class AddCountryToDeath14 < ActiveRecord::Migration
  def change
  	add_column :death14_registrations, :country, :string
  end
end
