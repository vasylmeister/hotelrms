class BedType < ApplicationRecord
  has_many :bed_type_associations
  has_many :rooms, through: :bed_type_associations
  
end
