class AddColumnsToJs17Registration < ActiveRecord::Migration
  def change
  	add_column :js17_registrations, :ateliers, :hstore
  end
end
