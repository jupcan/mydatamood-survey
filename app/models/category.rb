class Category < ApplicationRecord
    has_many :products
    scope :order_by_score, -> { order(score: :desc) }
end
