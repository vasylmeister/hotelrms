class PrivateBed < ApplicationRecord
  belongs_to :rooms
  
  validate :does_not_exceed_number_of_beds_in_shared_room,
    :only_shared_room_has_private_bed
  
  def does_not_exceed_number_of_beds_in_shared_room
    room = Room.find(room_id)
    if room.beds < room.private_beds.count + 1 
      # +1 is current private_bed that is being validated, we want to prevent it from being saved if condition is met
      errors.add(:room_id, "this room cannot have more private beds than number of beds it has")
    end
  end
  
  def only_shared_room_has_private_bed
    room = Room.find(room_id)
    errors.add(:room_id, "only shared room type can have private beds") unless room.type == "shared"
  end
  
end