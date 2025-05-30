require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'is valid with all required fields' do
      category = Category.new(name: "Succulent")
      product = Product.new(name: "Pilea", price: 20, quantity: 5, category: category)
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      category = Category.new(name: "Succulent")
      product = Product.new(name: nil, price: 20, quantity: 5, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      category = Category.new(name: "Succulent")
      product = Product.new(name: "Pilea", quantity: 5, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price cents can't be blank")
    end

    it 'is not valid without a quantity' do
      category = Category.new(name: "Succulent")
      product = Product.new(name: "Pilea", price: 20, quantity: nil, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      product = Product.new(name: "Pilea", price: 20, quantity: 5, category: nil)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

  end
end