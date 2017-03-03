class Card < ApplicationRecord
	belongs_to :cc_info, polymorphic: true
end
