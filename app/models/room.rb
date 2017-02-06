class Room < ApplicationRecord
  has_many :room_bed_types, inverse_of: :room, autosave: true, dependent: :destroy
  has_many :bed_types, through: :room_bed_types
  has_many :private_beds, dependent: :destroy
  
  accepts_nested_attributes_for :bed_types, reject_if: :all_blank
  accepts_nested_attributes_for :room_bed_types, allow_destroy: true
  
  #had to include this method to make things work. there is a known issue that prevents 
  def bed_types_attributes=(attributes)
    attr_array = attributes.collect {|item| item[1][:id] }
    self.bed_type_ids = attr_array
    super
  end
  
  # callbacks
  before_update :adjust_private_beds, if: :beds_changed? || :room_type_changed?
  
  PRIVACY_TYPE = ["private", "shared"]
  ROOM_SIZES = ['single', 'double','double-double', 'twin', 'triple', 'quadruple', 'family', 'studio']
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 8 }
  validates :pax, :max_pax, :beds, :bathrooms, numericality: { only_integer: true, less_than: 11, greater_than: 0 }
  validates :room_type, :bathroom_type, presence: true, inclusion: { in: PRIVACY_TYPE, message: "%{value} is not a valid privacy type" }
  validates :size, presence: true,  inclusion: { in: ROOM_SIZES, message: "%{value} is not a valid room size" }
  validates :floor, :extra_beds, numericality: { only_integer: true, allow_nil: true }
  
  # custom validations
  validate :max_capacity_cannot_be_less_than_capacity
  validate :bed_types_count_valid?, on: :create
  validate :room_bed_types_count_valid?, on: :update
  
  
  
  # cutom validation methods
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
      self.private_beds.create()
    end
  end
  
  private

    # adjust  private_beds for shared room if number of beds changed
    def adjust_private_beds
      if self.room_type == "shared"
        diff = self.beds - self.private_beds.count
          diff.abs.times {diff > 0 ? self.private_beds.create!() : self.private_beds.destroy(self.private_beds.last)}
      end
    end
  
    # this method was not working properly, so I had to make to separate validations for create and update actions
    # def bed_types_count_valid?
    #   errors.add(:beds, "Wrong number of bed types#{bed_types.size}") unless room_bed_types.reject(&:marked_for_destruction?).size == beds || bed_types.size == beds
    # end
    # error explanation: on create action room_bed_types.reject(&:marked_for_destruction?).size was getting wrong values
    
    #create validation
    def bed_types_count_valid?
       errors.add(:base, "Wrong number of bed types#{bed_types.size}") unless bed_types.size == beds
    end
    
    #update validation
    def room_bed_types_count_valid?
       errors.add(:base, "Wrong number of bed types#{bed_types.size}") unless room_bed_types.reject(&:marked_for_destruction?).count == beds
    end

end


