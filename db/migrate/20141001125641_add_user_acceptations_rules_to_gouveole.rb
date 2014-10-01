class AddUserAcceptationsRulesToGouveole < ActiveRecord::Migration
  def change
    add_column :gouveole_registrations, :certified_infos, :boolean
    add_column :gouveole_registrations, :accept_conditions, :boolean
  end
end
