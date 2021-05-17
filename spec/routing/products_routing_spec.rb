# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/products').to route_to('products#index')
    end

    it 'routes to #create' do
      expect(put: '/products').to route_to('products#create')
    end
  end
end
