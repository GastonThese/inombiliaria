class DropTableUnit < ActiveRecord::Migration[7.2]
  def change
    drop_table :units
  end
end
