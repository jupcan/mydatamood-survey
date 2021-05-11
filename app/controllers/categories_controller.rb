class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories
  def index
    @categories = Category.all
    if params[:q] == "score"
      products_mean
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

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category, status: :unprocessable_entity
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:category, :score)
    end

    def products_mean
      @categories.each do |category|
        score = 0
        products = category.products.each do |product|
          product.interests.each do |interest|
            score += interest.score
          end
        end
        average_score = score.to_f/products.count.to_f
        category.update(score: average_score)
      end
    end 

    def format_response
      response = @categories
      response = @categories.order_by_score if params[:reverse] == 'true'
      response = response.first(params[:limit].to_i) if params[:limit]
      response
    end 
end