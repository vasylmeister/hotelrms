class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :card_name, null: false
      t.string :number, null: false, unique: true
      t.string :type
      t.integer :exp_month, null: false
      t.integer :exp_year, null: false
      t.integer :cvv
      t.timestamps
    end
  end
end
