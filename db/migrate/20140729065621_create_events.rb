class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :short_name
      t.string :name
      t.string :description
      t.date :open
      t.date :close
      t.boolean :visible
      t.timestamps
    end
  end
end
