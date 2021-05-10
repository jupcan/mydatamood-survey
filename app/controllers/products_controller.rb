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
        created_products << Product.create(product_params(params))
      rescue ActiveRecord::Statement Invalid => e     
        render json: e.message, status: :unprocessable_entity
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
      params.permit(:id, :name, :category)
    end
end
