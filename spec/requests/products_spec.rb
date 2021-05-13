require 'swagger_helper'

RSpec.describe 'products', type: :request do
  path '/products' do

    put('load list of available products into the system') do
      tags :product
      produces 'application/json'
      consumes 'application/json'

      parameter name: :products, in: :body, schema: {
        type: :array,
        items: {
          type: :object,
            properties: {
              id: { type: :string, default: "1234abcd"},
              name: { type: :string, default: "Car Insurance for any damage" },
              category: { type: :string, default: "car_insurances"}
            },
            required: ["name", "category"],
        }
      }

      response(201, 'successful') do
        schema type: :array, name: :products, 
        items: {
          type: :object,
          properties: {
            id: { type: :string, default: "1234abcd"},
            name: { type: :string, default: "Car Insurance for any damage" },
            category: { type: :string, default: "car_insurances"}
          }
        }

        let!(:product) { Product.create(id: "1234567", name: "test_product", category: "test_category") }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["products"].size).to eq 1
          expect(data["products"].first["id"]).to eq "1234567"
        end
      end
    end

    get('query product data') do
      tags :product
      produces 'application/json'

      parameter name: :q, in: :query, type: :string, description: 'type of query to be run'
      parameter name: :limit, in: :query, type: :integer, description: 'limit in the number of results returned'
      parameter name: :reverse, in: :query, type: :boolean, description: 'flag to indicate the result ordering'


      response(200, 'list of products') do
        let!(:category) { Category.create(category: 'test category') }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["categories"].size).to eq 1
          expect(data["categories"].first["category"]).to eq "test category"
        end 
      end
    end
  end
end
