require 'swagger_helper'

RSpec.describe 'interests', type: :request do
  path '/interests' do
    post('load interest show by a user into a particular product') do
      tags :interest
      produces 'application/json'
      consumes 'application/json'
      parameter name: :interest, in: :body, schema: { '$ref' => '#/definitions/interest' }

      let!(:category) { Category.create(category: "test_category") }
      let!(:user) { User.create(id: "test_user", name: "test_user", email: "test_email@email.com") }
      let!(:product) { Product.create(id: "test_product", name: "test_product", category: category, score: 2.0) }

      response(201, 'successful') do
        schema oneOf: [ { '$ref' => '#/definitions/interest' } ]
        let(:interest) { { user_id: user.id, product_id: product.id, score: 4} }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response).to be_successful
          expect(response.content_type).to match(a_string_including("application/json"))
          expect(data["user_id"]).to eq "test_user"
          expect(data["product_id"]).to eq "test_product"
          expect(data["score"]).to eq 4
        end
      end

      response(422, 'users cannot score the same product twice') do
        2.times do
          let(:interest) { Interest.create(user_id: user.id, product_id: product.id, score: 4) }
        end
        run_test! 
      end

      response(422, 'score must be less than or equal to 10') do
        let(:interest) { { user_id: user.id, product_id: product.id, score: 11} }
        run_test! 
      end

      response(422, 'product must exist') do
        let(:interest) { { user_id: user.id, product_id: 100, score: 8} }
        run_test! 
      end
    end
  end
end
