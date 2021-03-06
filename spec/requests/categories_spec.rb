# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'categories', type: :request do
  path '/categories' do
    get('query category data') do
      tags :category
      produces 'application/json'
      parameter name: :q, in: :query, type: :string, description: 'type of query to be run'
      parameter name: :limit, in: :query, type: :integer, description: 'limit in the number of results returned'
      parameter name: :reverse, in: :query, type: :boolean, description: 'flag to indicate the result ordering'

      let!(:limit) { 2 }
      let!(:reverse) { true }
      let!(:category_1) { Category.create(category: 'test_category_1') }
      let!(:category_2) { Category.create(category: 'test_category_2') }

      response(200, 'list of categories') do
        schema type: :array, items: { '$ref' => '#/definitions/category' }

        examples 'application/json' => [
          { category: 'landline_internet', score: 8 },
          { category: 'race_cars', score: 7 },
          { category: 'stock_investment', score: 6.5 }
        ]

        let!(:q) { 'score' }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response).to be_successful
          expect(response.content_type).to match(a_string_including('application/json'))
          expect(data.size).to eq 2
          expect(data.first['category']).to eq 'test_category_1'
        end
      end

      response(400, 'unknown query type') do
        let!(:q) { 'test' }
        run_test!
      end
    end
  end
end
