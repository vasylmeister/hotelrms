class Room < ApplicationRecord
  has_many :private_beds, dependent: :destroy
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 8 }
  validates :size, :room_type, :pax, :max_pax, :beds, :bathrooms, :bathroom_type, presence: true
  validate :max_capacity_cannot_be_less_than_capacity
  
  def max_capacity_cannot_be_less_than_capacity
    if pax && max_pax
      if max_pax < pax
        errors.add(:max_pax, "Maximum capacity cannot be less than capacity")
      end
    end
  end
  
end
