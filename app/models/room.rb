class Room < ApplicationRecord
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 8 }
  validates :size, :room_type, :pax, :max_pax, :beds, :bathrooms, :bathroom_type, presence: true
  
end
