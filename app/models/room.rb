class Room < ApplicationRecord

  has_many :private_beds, dependent: :destroy
  
  PRIVACY_TYPE = ["private", "shared"]
  ROOM_SIZES = ['single', 'double','double-double', 'twin', 'triple', 'quadruple', 'family', 'studio']
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 8 }
  validates :pax, :max_pax, :beds, :bathrooms, numericality: { only_integer: true, less_than: 11, greater_than: 0 }
  validates :room_type, :bathroom_type, presence: true, inclusion: { in: PRIVACY_TYPE, message: "%{value} is not a valid privacy type" }
  validates :size, presence: true,  inclusion: { in: ROOM_SIZES, message: "%{value} is not a valid room size" }
  validates :floor, :extra_beds, numericality: { only_integer: true, allow_nil: true }
  validate :max_capacity_cannot_be_less_than_capacity
  
  # cutom validations
  def max_capacity_cannot_be_less_than_capacity
    if pax && max_pax
      if max_pax < pax
        errors.add(:max_pax, "Maximum capacity cannot be less than capacity")
      end
    end
  end
  
  # custom methods
  
  # create private beds for shared room
  def create_private_beds
    self.beds.times do
      @private_bed = self.private_beds.build()
      @private_bed.save
    end
  end
  
end
