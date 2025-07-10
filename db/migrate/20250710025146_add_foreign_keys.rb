class AddForeignKeys < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :properties, :buildings
    add_foreign_key :properties, :users, column: :owner_id
    add_foreign_key :properties, :users, column: :tenant_id
  end
end
