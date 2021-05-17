# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'products', type: :request do
  path '/products' do
    put('load list of available products into the system') do
      tags :product
      produces 'application/json'
      consumes 'application/json'
      parameter name: :products, in: :body, schema: { type: :array, items: { '$ref' => '#/definitions/product' } }

      response(201, 'successful') do
        schema type: :array, items: { '$ref' => '#/definitions/product' }

        let(:products) do
          [
            { id: 'test_product_1', name: 'test_product_1', category: 'test_category' },
            { id: 'test_product_2', name: 'test_product_2', category: 'test_category' }
          ]
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response).to be_successful
          expect(response.content_type).to match(a_string_including('application/json'))
          expect(data.count).to eq 2
          expect(data.first['id']).to eq 'test_product_1'
        end
      end
    end

    get('query product data') do
      tags :product
      produces 'application/json'
      parameter name: :q, in: :query, type: :string, description: 'type of query to be run'
      parameter name: :limit, in: :query, type: :integer, description: 'limit in the number of results returned'
      parameter name: :reverse, in: :query, type: :boolean, description: 'flag to indicate the result ordering'

      let!(:limit) { 2 }
      let!(:reverse) { true }
      let!(:category) { Category.create(category: 'test_category') }
      let!(:product_1) { Product.create(id: 'test_product_1', name: 'test_product_1', category: category, score: 5) }
      let!(:product_2) { Product.create(id: 'test_product_2', name: 'test_product_2', category: category, score: 2) }

      response(200, 'list of products') do
        let!(:q) { 'score' }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response).to be_successful
          expect(response.content_type).to match(a_string_including('application/json'))
          expect(data.size).to eq 2
          expect(data.first['product']['category']).to eq 'test_category'
          expect(data.second['product']['name']).to eq 'test_product_2'
          expect(data.first['score']).to be > data.second['score']
        end
      end

      response(400, 'unknown query type') do
        let!(:q) { 'test' }
        run_test!
      end
    end
  end
end
