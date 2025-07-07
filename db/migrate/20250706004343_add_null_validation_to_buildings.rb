class AddNullValidationToBuildings < ActiveRecord::Migration[7.2]
  def change
    change_column_null :buildings, :number, false
    change_column_null :buildings, :name, false
    change_column_null :buildings, :address, false
  end
end
