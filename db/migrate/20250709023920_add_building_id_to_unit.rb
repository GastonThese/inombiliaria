class AddBuildingIdToUnit < ActiveRecord::Migration[7.2]
  def change
    add_reference :units, :building, null: false, foreign_key: true, type: :uuid
  end
end
