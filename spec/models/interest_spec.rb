require 'rails_helper'

RSpec.describe Interest, type: :model do
  let(:user) { User.create(name: 'test_user')}
  let(:category) { Category.create(category: 'test_category')}
  let(:product) { Product.create(name: 'test_product', category: category)}
  let(:valid_attributes) { {user_id: user.id, product_id: product.id, score: 3.5} }
  subject(:interest) { Interest.new valid_attributes}

  it "is valid with valid attributes" do
    expect(interest).to be_valid
  end

  it "is not valid without a score" do
    interest.score = nil
    expect(interest).to_not be_valid
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end
end
