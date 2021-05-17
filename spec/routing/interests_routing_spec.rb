require 'rails_helper'

RSpec.describe InterestsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/interests').to route_to('interests#create')
    end
  end
end
