class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # PUT /products
  def create
    Product.destroy_all
    req_content = params[:_json].nil? ? [params[:product]] : params[:_json] 
    @products = req_content.inject([]) do |created_products, params|
      begin 
        category = Category.find_by(category: params[:category])
        category = Category.create(category: params[:category]) if category.blank?
        created_products << category.products.create(product_params(params.except(:category)))
      rescue ActiveRecord::StatementInvalid => e     
        render json: e.message, status: :unprocessable_entity
        raise
      end
    end
    render json: @products, status: :created
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params(params[:product]))
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params(params)
      params.permit(:id, :name, :category_id)
    end
end
