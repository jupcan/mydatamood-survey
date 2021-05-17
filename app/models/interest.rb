class Interest < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :product, uniqueness: { scope: :user, message: 'users cannot score the same product twice' } 
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }, presence: true
end
