class AddIndexTenantToPoperty < ActiveRecord::Migration[7.2]
  def change
    remove_index :properties, :tenant_id
    add_index :properties, :tenant_id, unique: true
  end
end
