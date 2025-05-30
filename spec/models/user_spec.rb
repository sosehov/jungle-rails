require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with all required fields' do
      user = User.new(
        first_name: "Soseh",
        last_name: "Yousefian",
        email: "soseh@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      expect(user).to be_valid
    end

    it 'is not valid without a password' do
      user = User.new(
        first_name: "Soseh",
        last_name: "Yousefian",
        email: "soseh@example.com",
        password: nil,
        password_confirmation: "password123"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid when password and confirmation do not match' do
      user = User.new(
        first_name: "Soseh",
        last_name: "Yousefian",
        email: "soseh@example.com",
        password: "password123",
        password_confirmation: "different123"
      )
      expect(user).not_to be_valid
    end

    it 'is not valid without a first name' do
      user = User.new(
        last_name: "Yousefian",
        email: "soseh@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      expect(user).not_to be_valid
    end

    it 'is not valid without a last name' do
      user = User.new(
        first_name: "Soseh",
        email: "soseh@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(
        first_name: "Soseh",
        last_name: "Yousefian",
        password: "password123",
        password_confirmation: "password123"
      )
      expect(user).not_to be_valid
    end

    it 'requires a unique email (case insensitive)' do
      User.create!(
        first_name: "Soseh",
        last_name: "Yousefian",
        email: "TEST@EMAIL.COM",
        password: "password123",
        password_confirmation: "password123"
      )
      user2 = User.new(
        first_name: "Another",
        last_name: "User",
        email: "test@email.com",
        password: "password123",
        password_confirmation: "password123"
      )
      expect(user2).not_to be_valid
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'is not valid with a short password (< 6 characters)' do
      user = User.new(
        first_name: "Soseh",
        last_name: "Yousefian",
        email: "soseh@example.com",
        password: "123",
        password_confirmation: "123"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create!(
        first_name: "Soseh",
        last_name: "Yousefian",
        email: "test@user.com",
        password: "password123",
        password_confirmation: "password123"
      )
    end
  
    it 'authenticates with valid credentials' do
      user = User.authenticate_with_credentials("test@user.com", "password123")
      expect(user).to eq(@user)
    end
  
    it 'returns nil with incorrect password' do
      user = User.authenticate_with_credentials("test@user.com", "wrongpassword")
      expect(user).to be_nil
    end
  
    it 'authenticates even with leading/trailing spaces in email' do
      user = User.authenticate_with_credentials("  test@user.com  ", "password123")
      expect(user).to eq(@user)
    end
  
    it 'authenticates with email in different case' do
      user = User.authenticate_with_credentials("TEST@USER.COM", "password123")
      expect(user).to eq(@user)
    end
  end
end
