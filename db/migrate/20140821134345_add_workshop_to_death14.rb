class AddWorkshopToDeath14 < ActiveRecord::Migration
  def change
  	add_column :death14_registrations, :workshop, :string
  end
end
