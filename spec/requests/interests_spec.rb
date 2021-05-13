require 'swagger_helper'

RSpec.describe 'interests', type: :request do
  path '/interests' do
    post('load interest show by a user into a particular product') do
      tags :interest
      produces 'application/json'
      consumes 'application/json'

      parameter name: :interest, in: :body, schema: {
        type: :object,
          properties: {
            user_id: { type: :string, default: "asdfasdf123" },
            product_id: { type: :string, default: "1234abcd" },
            score: { type: :number, format: :double, default: 7}
          },
          required: ["name", "category"],
      }

      response(201, 'successful') do

        schema type: :object, name: :interest, 
        properties: {
          user_id: { type: :string, default: "asdfasdf123" },
          product_id: { type: :string, default: "1234abcd" },
          score: { type: :number, format: :double, default: 7 }
        }

        let!(:product) { Product.create(id: "1234567", name: "test_product", category: "test_category") }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["products"].size).to eq 1
          expect(data["products"].first["id"]).to eq "1234567"
        end
      end
    end
  end
end
