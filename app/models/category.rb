class Category < ApplicationRecord
    include OrderScoreConcern
    has_many :products
end
