class ProductsController < ApplicationController

  # GET /products
  def index
    @products = Product.all
    if params[:q] == "score"
      @products.each do |product|
        product.update(score: product.interests.average(:score).round(2)) unless product.interests.empty?
      end
      render json: format_response, each_serializer: ScoreProductSerializer, status: :ok
    else
      render json: 'Unknown type of query provided. Please, try again.', status: :bad_request
    end
  end

  # PUT /products
  def create
    Product.destroy_all # deletes all products and their dependent interests 
    req_content = params[:_json].nil? ? [params] : params[:_json] # array of objects or just one instance
    @products = req_content.map do |product|
      category = Category.find_or_create_by(category: product[:category])
      category.products.create(product_params(product.except(:category)))
    end
    render json: @products, status: :created
  end

  private
    def product_params(params)
      params.permit(:id, :name)
    end

    def format_response
      response = @products
      response = @products.order_by_score if params[:reverse] == 'true'
      response = response.first(params[:limit].to_i) if params[:limit]
      response
    end 
end
