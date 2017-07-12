class AddColumnAteliersToPsy17Registration < ActiveRecord::Migration
  def change
  	add_column :psy17_registrations, :ateliers, :hstore
  end
end
