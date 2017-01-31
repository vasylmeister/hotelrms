class CreateRoomBedTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :room_bed_types do |t|
      t.belongs_to :room, index: true
      t.belongs_to :private_bed
    end
  end
end
