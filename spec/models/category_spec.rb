# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:valid_attributes) { { category: 'test_category' } }
  subject(:category) { Category.new valid_attributes }

  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end

  it 'is not valid without a category name' do
    category.category = nil
    expect(category).to_not be_valid
  end

  describe 'associations' do
    it { should validate_presence_of(:category) }
    it { should have_many(:products) }
  end
end
