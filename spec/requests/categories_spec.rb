require 'swagger_helper'

RSpec.describe 'categories', type: :request do
  path '/categories' do

    get('query category data') do
      tags :category
      produces 'application/json'

      parameter name: :q, in: :query, type: :string, description: 'type of query to be run'
      parameter name: :limit, in: :query, type: :integer, description: 'limit in the number of results returned'
      parameter name: :reverse, in: :query, type: :boolean, description: 'flag to indicate the result ordering'

      response(200, 'list of categories') do
        schema type: :array, name: :categories, 
        items: {
          type: :object,
          properties: {
            category: { type: :string, default: "landline_internet" },
            score: { type: :number, format: :double, default: 4.0},
          }
        }

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