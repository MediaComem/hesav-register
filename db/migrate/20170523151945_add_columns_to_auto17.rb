class AddColumnsToAuto17 < ActiveRecord::Migration
  def change
  	add_column :auto17_registrations, :food, :boolean
    add_column :auto17_registrations, :translate, :boolean
  end
end
