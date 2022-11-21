require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "confirms valid entry" do
      @newCategory = Category.new
      @newCategory.name = 'Test Category'
      @product = Product.new
      @product.category = @newCategory
      @product.name = 'Test Product'
      @product.quantity = 13
      @product.price_cents = 12345
      @product.valid?
      expect(@product.valid?).to be true
    end

    it "confirms name presence" do
      @product = Product.new
      #error
      @product.name = nil
      @product.valid?
      expect(@product.errors[:name]).to  include("can't be blank")

      #valid
      @product.name = 'test'
      @product.valid? 
      expect(@product.errors[:name]).not_to  include("can't be blank")
    end

    it "confirms price presence" do
      @product = Product.new
      #error
      @product.price_cents = nil
      @product.valid?
      expect(@product.errors[:price_cents]).to  include("is not a number")
  
      #valid
      @product.price_cents = 12345 #price in cents
      @product.valid? 
      expect(@product.errors[:price_cents]).not_to  include("can't be blank")
    end

    it "confirms quantity presence" do
      @product = Product.new
      #error
      @product.quantity = nil
      @product.valid?
      expect(@product.errors[:quantity]).to  include("can't be blank")
  
      #valid
      @product.quantity = 12
      @product.valid? 
      expect(@product.errors[:quantity]).not_to  include("can't be blank")
    end

    it "confirms category presence" do
      #error
      @newCategory = Category.new
      @product = Product.new
      @product.category = nil
      @product.valid?
      expect(@product.errors[:category]).to  include("can't be blank")
  
      #valid
      @newCategory.name = 'Test Category'
      @product.category = @newCategory
      @product.valid?
      expect(@product.errors[:category]).not_to  include("can't be blank")
  
    end
  end
end