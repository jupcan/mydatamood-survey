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

  # POST /products
  def create
    Product.destroy_all
    @products = params[:_json].inject([]) do |created_products, product|
      begin 
        created_products << Product.create(product_params(product))
      rescue ActiveRecord::RecordInvalid => e     
        render json: e.message, status: :unprocessable_entity
      end
    end
    render json: @products, status: :created
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params(product)
      product.permit(:id, :name, :category)
    end
end
