class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false, index: true
      t.string :phone_number, null: false, index: true
      t.string :email
      t.timestamps
    end
  end
end
