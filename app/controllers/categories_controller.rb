# frozen_string_literal: true

class CategoriesController < ApplicationController
  # GET /categories
  def index
    @categories = Category.all
    if params[:q] == 'score'
      category_products_mean
      render json: format_response, status: :ok
    else
      render json: 'Unknown type of query provided. Please, try again.', status: :bad_request
    end
  end

  private

  def category_products_mean
    @categories.each do |category|
      category_interests = category.products.map(&:interests).flatten.map(&:score)
      unless category_interests.empty?
        average_score = category_interests.sum.to_f / category_interests.count
        category.update(score: average_score.round(2))
      end
    end
  end

  def format_response
    response = @categories
    response = @categories.order_by_score if params[:reverse] == 'true'
    response = response.first(params[:limit].to_i) if params[:limit]
    response
  end
end
