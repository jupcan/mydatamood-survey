class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories
  def index
    average_score = 0
    if params[:q] == "score"
      @categories = Category.all
      @categories.each do |category|
        score = 0
        products = category.products.each do |product|
          puts "test: #{category.products.count}"
          puts "test: #{product.interests.average(:score)}"
          test_score = product.interests.average(:score)
          product.interests.each do |interest|
            score += interest.score
          end
        end
        average_score = score.to_f/products.count.to_f
        category.update(score: average_score.round)
      end
      render json: @categories
    else
      render json: 'Unknown type of query provided, try again.', status: :unprocessable_entity
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
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:category, :score)
    end
end
