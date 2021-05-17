# frozen_string_literal: true

class InterestSerializer < ActiveModel::Serializer
  attributes :user_id, :product_id, :score
end
