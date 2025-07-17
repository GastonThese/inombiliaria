class CreateProperties < ActiveRecord::Migration[7.2]
  def change
    create_table :properties, id: :uuid do |t|
      t.integer :number

      t.timestamps
    end
  end
end
