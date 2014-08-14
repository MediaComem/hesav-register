class CreateGouveoleRegistrations < ActiveRecord::Migration
  def change
    create_table :gouveole_registrations do |t|
      t.string :title
      t.string :last_name
      t.string :first_name
      t.string :affiliation #choix : association, entreprise, administration, elus
      t.string :affiliation_address
      t.string :job #position/poste/responsabilités
      t.string :email
      t.string :phone
      
      #choix : theorique, pratique comme participant, #pratique comme organisateur, aucune connaissance
      t.boolean :theorical_knowledge 
      t.boolean :practical_p_knowledge
      t.boolean :practical_o_knowledge
      t.boolean :no_knowledge

      t.string :expectations
      t.string :activities
      t.string :remarks
      t.integer :price
      t.boolean :paid
      t.boolean :rules_accepted

      t.timestamps

      t.integer :event_id
    end
  end
end
