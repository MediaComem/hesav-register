class AddTeamToTrm30 < ActiveRecord::Migration
  def change
  	add_column :trm30_registrations, :team, :string
  end
end
