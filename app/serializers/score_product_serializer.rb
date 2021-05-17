class ScoreProductSerializer < ActiveModel::Serializer
  attributes :product, :score

  def product 
    {
      product_id: object.id,
      name: object.name,
      category: object.category.category
    }
  end
end