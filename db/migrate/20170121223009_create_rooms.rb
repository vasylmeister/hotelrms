class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :size
      t.string :room_type
      t.integer :pax
      t.integer :max_pax
      t.integer :beds
      t.integer :extra_beds, default: 0
      t.integer :bathrooms
      t.string :bathroom_type
      t.integer :floor
      t.text :description

      t.timestamps
    end
  end
end
