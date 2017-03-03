class Client < ApplicationRecord

  has_many :cards, as: :cc_info

  scope :not_deleted, lambda { where(deleted_at: nil) }

  validates :first_name, :last_name, presence: true, length: {maximum: 128}
  validates :phone_number, presence: true, uniqueness: { scope: :email }, length: {maximum: 20}, format: { with:/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/, message: " not valid" }
  validates :email, presence: true, length: {maximum: 75}, format: { with:/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "not valid" }

  accepts_nested_attributes_for :cards


  private
    def destroy
      self.update_attributes(deleted_at: DateTime.current)
    end

    def delete
      destroy
    end
    
    def deleted?
      self.deleted_at.present?
    end
end
