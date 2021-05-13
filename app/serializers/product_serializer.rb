class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :category

  def category
    object.category.category 
  end
end
