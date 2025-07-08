class CreateBuildings < ActiveRecord::Migration[7.2]
  def change
    create_table :buildings, id: :uuid do |t|
      t.integer :number
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
