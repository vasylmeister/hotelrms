class AddDeletedAtFieldToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :deleted_at, :timestamp
  end
end
