class CreateGouveoleRegistrations < ActiveRecord::Migration
  def change
    create_table :gouveole_registrations do |t|
      t.boolean :male
      t.string :last_name
      t.string :first_name
      t.string :affiliation #choix : association, entreprise, administration, elus
      t.string :affiliation_address
      t.string :job #position/poste/responsabilités
      t.string :email
      t.string :phone
      t.string :billing_address
      t.string :city
      t.string :knowledge #choix : theorique, pratique comme participant, #pratique comme organisateur, aucune connaissance
      t.string :expectations
      t.string :activities
      t.string :remarks
      
      t.string :shopID
      t.string :environment
      t.string :language
      t.integer :price
      t.boolean :paid

      t.timestamps

      t.integer :event_id
    end
  end
end
