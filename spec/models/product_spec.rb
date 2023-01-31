require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
  
    it "will save successfully when all four fields are set" do      
      @category = Category.new
      @product = Product.new
      @category.name = 'test'
      @product.name = 'test'
      @product.price_cents = 999
      @product.quantity = 9
      @product.category = @category
      expect(@product.valid?).to be true
    end

    it "will fail when the name field is not set" do
      @category = Category.new
      @product = Product.new
      @category.name = 'test'
      @product.name = nil
      @product.price_cents = 999
      @product.quantity = 9
      @product.category = @category
      @product.valid?
      puts @product.errors.full_messages
      expect(@product.errors[:name]).to include("can't be blank")
    end

    it "will fail when the price field is not set" do
      @category = Category.new
      @product = Product.new
      @category.name = 'test'
      @product.name = 'test'
      @product.price_cents = nil
      @product.quantity = 9
      @product.category = @category
      @product.valid?
      puts @product.errors.full_messages
      expect(@product.errors[:price]).to include("can't be blank")
    end
  
    it "will fail when the quantity field is not set" do
      @category = Category.new
      @product = Product.new
      @category.name = 'test'
      @product.name = 'test'
      @product.price_cents = 999
      @product.quantity = nil
      @product.category = @category
      @product.valid?
      puts @product.errors.full_messages
      expect(@product.errors[:quantity]).to include("can't be blank")
    end
  
    it "will fail when the category field is not set" do
      @category = Category.new
      @product = Product.new
      @category.name = 'test'
      @product.name = 'test'
      @product.price_cents = 999
      @product.quantity = 9
      @product.category = nil
      @product.valid?
      puts @product.errors.full_messages
      expect(@product.errors[:category]).to include("can't be blank")
    end

  end
end