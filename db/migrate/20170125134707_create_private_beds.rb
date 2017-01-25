class CreatePrivateBeds < ActiveRecord::Migration[5.0]
  def change
    create_table :private_beds do |t|
      t.references :room, index: true, foreign_key: true
    end
  end
end
