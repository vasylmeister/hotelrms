class AddIdAndTypeToCard < ActiveRecord::Migration[5.0]
  def change
  	add_column :cards, :cc_info_id, :integer
  	add_column :cards, :cc_info_type, :string
  end
end
