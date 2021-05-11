class Product < ApplicationRecord
  after_initialize :generate_uuid
  belongs_to :category
  has_many :interests
end
