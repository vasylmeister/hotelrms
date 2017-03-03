class ChangeColumnNameInCards < ActiveRecord::Migration[5.0]
  def change
  	rename_column :cards, :type, :card_type
  end
end
