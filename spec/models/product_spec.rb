require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'a product with all four fields set' do
      it('save save successfully') do
        @category = Category.new(name:'test')
        @product = @category.products.new({
          name:  'Name',
          quantity: 18,
          price: 124.99
        })
        @product.save!
      end
    end
    describe 'a product with only one fields set' do
      it('should not save if name is missed') do
        @category = Category.new(name:'test')
        @product = @category.products.new({
          quantity: 18,
          price: 124.99
        })
        @product.save
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
      it('should not save if quantity is missed') do
        @category = Category.new(name:'test')
        @product = @category.products.new({
          name: "product",
          price: 124.99
        })
        @product.save
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
      
      it('should not save if price is missed') do
        @category = Category.new(name:'test')
        @product = @category.products.new({
          name: "product",
          quantity: 18,
        })
        @product.save
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      
      it('should not save if category is missed') do
        @product = Product.new({
          name: "product",
          price: 124.99,
          quantity: 18,
        })
        @product.save
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end