class RoomBedType < ApplicationRecord
  belongs_to :room
  belongs_to :bed_type
  
  validates :bed_type_id, presence: true

  accepts_nested_attributes_for :bed_type
end
