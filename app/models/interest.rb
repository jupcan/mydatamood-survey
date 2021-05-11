class Interest < ApplicationRecord
  belongs_to :user
  belongs_to :product
  # users can not score same product twice
  validates :product, uniqueness: {scope: :user} 
end
