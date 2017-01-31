class BedType < ApplicationRecord
  has_many :room_bed_types
  has_many :rooms, through: :room_bed_types
  
end
