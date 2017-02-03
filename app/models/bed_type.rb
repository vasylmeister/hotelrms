class BedType < ApplicationRecord
  has_many :room_bed_types, inverse_of: :bed_type
  has_many :rooms, through: :room_bed_types
  
  validates :name, presence: true, allow_nil: false
  
end
