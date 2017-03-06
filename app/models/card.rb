class Card < ApplicationRecord

	belongs_to :cc_info, polymorphic: true


	# add real credit card validation, fix regular expressions
	validates :card_name, presence: true, format: { with: /\A[A-Za-z -]+\z/, message: " not valid" }
	validates :number, presence: true, format: { with: /\A([\d\s-])+\z/, message: " not valid" }
	validates :exp_month, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 13 }
	validates :exp_year, 
		presence: true, 
		numericality: { 
			only_integer: true, 
			greater_than_or_equal_to: ->(_card) { Date.current.year%1000 }, 
			less_than: ->(_card) {Date.current.year%1000 + 8}
		}
	validates :card_type, inclusion: { in: %w(Visa MasterCard), message: "%{value} is not a valid card type" }, allow_blank: true
	validates :cvv, format: { with: /((\d)\w*){3}/ }, allow_blank: true

end
