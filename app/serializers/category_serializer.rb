# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes :category, :score
end
