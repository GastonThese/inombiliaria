class NotNullNumberProperties < ActiveRecord::Migration[7.2]
  def change
    change_column_null :properties, :number, false
  end
end
