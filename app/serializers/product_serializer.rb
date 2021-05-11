class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :category
end
