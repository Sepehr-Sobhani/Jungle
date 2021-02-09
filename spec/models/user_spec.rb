require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = User.new({
                      name: 'test_name',
                      email: 'test@email.com',
                      password: '123456',
                      password_confirmation: '123456'
                      })
  end

  describe "Validations" do
    
    it "should save the user with all fields set" do
      @user.save!
      expect(@user).to be_valid  
    end

    it "should not save user with nil password" do
      @user.password = nil
      @user.password_confirmation = nil

      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should not save user with wrong password confirmation" do
      @user.password_confirmation = "1234567"
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it "should not save user with an existing email" do
      @newuser = User.new({
                          name: 'test_name2',
                          email: 'test@email.com',
                          password: '123456',
                          password_confirmation: '123456'
                          })
        
        @newuser.save
        @user.save
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
      
      
      it "should not save user with password length less than 6" do
        @user.password = "1234"
        @user.password_confirmation = "1234"
        @user.save
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
  end

  describe '.authenticate_with_credentials' do
    it "should save the user if authenticated" do
      @user.save!
      @user = User.authenticate_with_credentials('test@email.com','123456')
      expect(@user).not_to be(nil)  
    end

    it "should save user with email case in-sensitive" do
      @user.save!
      @user = User.authenticate_with_credentials('TEST@email.com', '123456')
      expect(@user).not_to be(nil) 
    end

    it "should not save the user if provided info is not correct" do
      @user.save!
      @user = User.authenticate_with_credentials('test@email.com', '1234')
      expect(@user).to be(nil)
    end

    it "should save user if has spaces before/after their email" do
      @user.save!
      @user = User.authenticate_with_credentials('  test@email.com  ', '123456')
      expect(@user).not_to be(nil) 
    end
  end
end
