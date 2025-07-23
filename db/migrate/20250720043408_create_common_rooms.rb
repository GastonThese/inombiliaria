class CreateCommonRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :common_rooms, id: :uuid do |t|
      t.string :name
      t.references :building, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
