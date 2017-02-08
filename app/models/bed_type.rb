class BedType < ApplicationRecord
  has_many :room_bed_types
  has_many :rooms, through: :room_bed_types
  
  validates :name, presence: true, allow_nil: false
  
end
