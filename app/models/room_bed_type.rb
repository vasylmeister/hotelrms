class RoomBedType < ApplicationRecord
  belongs_to :room, inverse_of: :room_bed_types
  belongs_to :bed_type, inverse_of: :room_bed_types
  
  accepts_nested_attributes_for :bed_type
end
