class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /categories
  def index
    @categories = Category.all
    if params[:q] == "score"
      category_products_mean
      render json: format_response
    else
      render json: 'Unknown type of query provided. Please, try again.', status: :bad_request
    end
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:category, :score)
    end

    def category_products_mean
      @categories.each do |category|
        category_interests = category.products.map(&:interests).flatten.map(&:score)
        average_score = category_interests.sum.to_f/category_interests.count.to_f
        category.update(score: average_score.round(2))
      end
    end 

    def format_response
      response = @categories
      response = @categories.order_by_score if params[:reverse] == 'true'
      response = response.first(params[:limit].to_i) if params[:limit]
      response
    end 
end