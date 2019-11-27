require "rails_helper"

RSpec.describe Product, type: :model do
  describe "Validations" do

    it "Product is valid" do
      @product = Product.new
      @category = Category.new
      @category.name = "Test"
      @product.name = "Test"
      @product.price_cents = 34321
      @product.category = @category
      @product.quantity = 2

      expect(@product.valid?).to be true
    end

    it "Product name is valid" do
      @product = Product.new
      @product.name = nil
      @product.valid?
      expect(@product.errors[:name]).to  include("can't be blank")

      @product.name = "test"
      @product.valid?
      expect(@product.errors[:name]).not_to  include("can't be blank")
    end

    it "Product price is valid" do
      @product = Product.new
      @product.price_cents = nil
      @product.valid?
      expect(@product.errors[:price]).to  include("is not a number")

      @product.price_cents = 21412
      @product.valid?
      expect(@product.errors[:price]).not_to  include("is not a number")
    end

    it "Product quantity is valid" do
      @product = Product.new
      @product.quantity = nil
      @product.valid?
      expect(@product.errors[:quantity]).to  include("can't be blank")

      @product.quantity = 21342
      @product.valid?
      expect(@product.errors[:quantity]).not_to  include("can't be blank")
    end

    it "Product category is valid" do
      @product = Product.new
      @category = Category.new
      @product.category = nil
      @product.valid?
      expect(@product.errors[:category]).to  include("can't be blank")

      @product.category = @category
      @product.valid?
      expect(@product.errors[:category]).not_to  include("can't be blank")

    end
  end
end