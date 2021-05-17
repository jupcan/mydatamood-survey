require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { Category.create(category: 'test_category')}
  let(:valid_attributes) { {name: 'test_product', category: category} }
  subject(:product) { Product.new valid_attributes}

  it "is valid with valid attributes" do
    expect(product).to be_valid
  end

  it "is not valid without a name" do
    product.name = nil
    expect(product).to_not be_valid
  end

  it "is not valid without a category" do
    product.category = nil
    expect(product).to_not be_valid
  end

  describe "associations" do
    it { should belong_to(:category) }
    it { should have_many(:interests) }
  end
end
