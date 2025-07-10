class AddRelationsToPropertyBuilding < ActiveRecord::Migration[7.2]
  def change
    add_column :properties, :building_id, :uuid, null: true

    add_index :properties, :building_id
  end
end
