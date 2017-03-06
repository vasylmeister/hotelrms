class UpdateCvvColumnTypeInCard < ActiveRecord::Migration[5.0]
	def change
		change_column :cards, :cvv, :string
	end
end
