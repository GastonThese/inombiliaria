class AddTypeAndAddressToProperties < ActiveRecord::Migration[7.2]
  def change
    add_column :properties, :type, :string
    add_column :properties, :address, :string
  end
end
