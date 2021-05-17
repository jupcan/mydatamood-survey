class Category < ApplicationRecord
  include OrderScoreConcern
  has_many :products
  validates :category, presence: true
end
