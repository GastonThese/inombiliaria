class NotNullToUnit < ActiveRecord::Migration[7.2]
  def change
    change_column_null :units, :number, false
  end
end
