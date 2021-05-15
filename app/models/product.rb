class Product < ApplicationRecord
  include OrderScoreConcern
  after_initialize :generate_uuid
  belongs_to :category
  has_many :interests, dependent: :delete_all
end
