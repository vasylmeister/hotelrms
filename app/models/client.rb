class Client < ApplicationRecord
    
    validates :first_name, :last_name, presence: true, length: {maximum: 128}
    validates :phone_number, presence: true, uniqueness: { scope: :email }, length: {maximum: 20}, format: { with:/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/, message: " not valid" }
    validates :email, presence: true, length: {maximum: 75}, format: { with:/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "not valid" }
    
end
