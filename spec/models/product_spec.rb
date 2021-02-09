require 'rails_helper'

RSpec.describe Product, type: :model do
  
  before(:each) do
    @category = Category.new(name: "Books")
    @category.save!
    @product = Product.new({
                            name: "How to use Rspec",
                            price_cents: 45,
                            quantity: 20,
                            category_id: @category.id
                            })
  end

  describe "Validations" do

    it "should save the product with all fields set" do
      @product.save!
      expect(@product).to be_valid    
    end

    it "should return proper error when name field is nil" do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")    
    end

    it "should return proper error when price field is nil" do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")    
    end

    it "should return proper error when quantity field is nil" do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")    
    end

    it "should return proper error when category id field is nil" do
      @product.category_id = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")    
    end
  end
end
