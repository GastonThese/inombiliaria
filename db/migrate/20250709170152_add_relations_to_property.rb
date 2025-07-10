class AddRelationsToProperty < ActiveRecord::Migration[7.2]
  def change
    add_column :properties, :owner_id, :uuid, null: true
    add_column :properties, :tenant_id, :uuid, null: true

    add_index :properties, :owner_id
    add_index :properties, :tenant_id
  end
end
