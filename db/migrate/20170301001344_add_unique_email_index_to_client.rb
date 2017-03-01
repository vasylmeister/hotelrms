class AddUniqueEmailIndexToClient < ActiveRecord::Migration[5.0]
  def change
    remove_index :clients, :phone_number
    add_index :clients, [:phone_number, :email], unique: true
  end
end
