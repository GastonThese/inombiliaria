class MakeUniqueBuildingNumberUnique < ActiveRecord::Migration[7.2]
  def change
    add_index :buildings, :number, unique: true
  end
end
