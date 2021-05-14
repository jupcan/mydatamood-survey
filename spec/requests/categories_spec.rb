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
            category: { type: :string },
            score: { type: :float },
          }
        }

        examples 'application/json' => [ 
          { category: "landline_internet", score: 8 },
          { category: "race_cars", score: 7 },
          { category: "stock_investment", score: 6.5 } 
        ]

        let!(:q) { 'score' }
        let!(:limit) { 1 }
        let!(:reverse) { true }
        let!(:category) { Category.create(category: "test_category") }
        
        run_test! do |response|
          data = JSON.parse(response.body)
          puts data
          expect(response).to be_successful
          expect(response.content_type).to match(a_string_including("application/json"))
          expect(data.size).to eq 1
          expect(data.first["category"]).to eq "test_category"
        ednd 
      end
    end
  end
end