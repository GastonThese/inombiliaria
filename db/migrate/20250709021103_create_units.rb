class CreateUnits < ActiveRecord::Migration[7.2]
  def change
    create_table :units, id: :uuid do |t|
      t.integer :number

      t.timestamps
    end
  end
end
