require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "user is valid" do
      @user = User.new(first_name: "first name", last_name:"last name", email: "email@email.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
    end

    it "email is not valid" do
      @user = User.new(first_name: "first name", last_name:"last name", password: "password", password_confirmation: "password")
      expect(@user).to be_invalid
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it "first name is not valid" do
      @user = User.new(last_name:"last name", password: "password", password_confirmation: "password")
      expect(@user).to be_invalid
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it "last name is not valid" do
      @user = User.new(first_name: "first name", password: "password", password_confirmation: "password")
      expect(@user).to be_invalid
      expect(@user.errors[:last_name]).to include("can't be blank")
    end

    it "password is missing" do
      @user = User.new(first_name: "first name", last_name:"last name", password_confirmation: "password")
      expect(@user).to be_invalid
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it "password confirmation doesn't match" do
      @user = User.new(first_name: "first name", last_name:"last name", password: "password", password_confirmation: "helpMePlease")
      expect(@user).to be_invalid
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "email is not unique" do
      @user = User.new(first_name: "first name", last_name:"last name", email: "email@email.com", password: "password", password_confirmation: "password")
      @user.save

      @user2 = User.new(first_name: "first name", last_name:"last name", email: "email@email.com", password: "password", password_confirmation: "password")
      @user2.save

      expect(@user2.errors[:email]).to include("has already been taken")
    end
  end

  describe ".authenticate_with_credentials" do

    it "should pass with valid credentials" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "email@email.com", password: "password", password_confirmation: "password")
      @user.save

      @user = User.authenticate_with_credentials("email@email.com", "password")
      expect(@user).not_to be(nil)
    end

    it "should not pass with invalid credentials" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "email@email.com", password: "password", password_confirmation: "password")
      @user = User.authenticate_with_credentials("email@email.com", "pass")
      expect(@user).to be(nil)
    end

    it "should pass even with spaces present in email" do
      user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "email@email.com",
        password: "password",
        password_confirmation: "password"
      )
      user.save

      user = User.authenticate_with_credentials("  email@email.com  ", "password")
      expect(user).not_to be(nil)
    end

    it "should pass even with spaces present in email" do
      user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "email@email.com",
        password: "password",
        password_confirmation: "password"
      )
      user.save

      user = User.authenticate_with_credentials("eMAil@email.com", "password")
      expect(user).not_to be(nil)
    end
  end
end