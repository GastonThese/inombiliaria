class AddReferencesToUnit < ActiveRecord::Migration[7.2]
  def change
    add_column :units, :owner_id, :uuid, null: true
    add_column :units, :tenant_id, :uuid, null: true

    add_index :units, :owner_id
    add_index :units, :tenant_id
  end
end
