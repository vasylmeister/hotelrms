class Client < ApplicationRecord
    
    validates :first_name, :last_name, presence: true, length: {maximum: 128}
    validates :phone_number, presence: true, uniqueness: true, length: {maximum: 20}, format: { with:/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/, message: " not valid" }
    validates :email, presence: true, length: {maximum: 75}, uniqueness: { case_sensitive: false }
    
end
