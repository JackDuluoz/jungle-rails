require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is valid when all five fields are set" do
      @user = User.new
      @user.first_name =  'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'
      expect(@user.valid?).to be true
    end

    it "is not valid when first name is not set" do
      @user = User.new
      @user.first_name =  nil
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      puts @user.errors.full_messages
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it "is not valid when last name is not set" do
      @user = User.new
      @user.first_name =  'john'
      @user.last_name = nil
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      puts @user.errors.full_messages
      expect(@user.errors[:last_name]).to include("can't be blank")
    end

    it "is not valid when email is not set" do
      @user = User.new
      @user.first_name =  'john'
      @user.last_name = 'smith'
      @user.email = nil
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      puts @user.errors.full_messages
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it "is not valid when password is not set" do
      @user = User.new
      @user.first_name =  'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = nil
      @user.password_confirmation = 'password'
      @user.valid?
      puts @user.errors.full_messages
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it "is not valid when password_confirmation is not set" do
      @user = User.new
      @user.first_name =  'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = nil
      @user.valid?
      puts @user.errors.full_messages
      expect(@user.errors[:password_confirmation]).to include("can't be blank")
    end

    it "is not valid when password and password_confirmation do not match" do
      @user = User.new
      @user.first_name =  'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'notthesamepassword'
      @user.valid?
      puts @user.errors.full_messages
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is not valid when passed an existing email" do
      @user = User.new
      @user.first_name =  'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.save

      @second_user = User.new
      @second_user.first_name =  'john'
      @second_user.last_name = 'smith'
      @second_user.email = 'john@email.com'
      @second_user.password = 'password'
      @second_user.password_confirmation = 'password'
      @second_user.save

      puts @second_user.errors.full_messages
      expect(@second_user.errors[:email]).to include('has already been taken')
    end

    it "is does not use case sensitivity when checking existing emails" do
      @user = User.new
      @user.first_name =  'john'
      @user.last_name = 'smith'
      @user.email = 'lower@case.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.save

      @second_user = User.new
      @second_user.first_name =  'john'
      @second_user.last_name = 'smith'
      @second_user.email = 'LOWER@CASE.com'
      @second_user.password = 'password'
      @second_user.password_confirmation = 'password'
      @second_user.save

      puts @second_user.errors.full_messages
      expect(@second_user.errors[:email]).to include('has already been taken')
    end

    it 'is not valid when password length is less than 5 characters' do
      @user = User.new
      @user.first_name = 'john'
      @user.last_name = 'smith'
      @user.email = 'john@smith.com'
      @user.password = 'pass'
      @user.password_confirmation = 'pass'
      @user.valid?
      puts @user.errors.full_messages
      expect(@user.errors[:password]).to include('is too short (minimum is 5 characters)')
    end

    it 'password length must be at-least 5 characters' do
      @user = User.new
      @user.first_name = 'john'
      @user.last_name = 'smith'
      @user.email = 'john@smith.com'
      @user.password = 'passw'
      @user.password_confirmation = 'passw'
      puts @user.errors.full_messages
      expect(@user).to be_valid
    end
  end

  describe '.authenticate_with_credentials' do

     it 'should authenticate with valid credentials' do
      @user = User.new
      @user.first_name = 'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'      
      @user.save

      test_user = User.authenticate_with_credentials('john@email.com', 'password')
      expect(test_user).not_to be(nil)
    end

    it 'should not authenticate with invalid email' do
      @user = User.new
      @user.first_name = 'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'      
      @user.save

      test_user = User.authenticate_with_credentials('john@email1.com', 'password')
      expect(test_user).to be(nil)
    end

    it 'should not authenticate with invalid password' do
      @user = User.new
      @user.first_name = 'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'      
      @user.save

      test_user = User.authenticate_with_credentials('john@email.com', 'password1')
      expect(test_user).to be(nil)
    end

    it 'should still authenticate with spaces in email' do
      @user = User.new
      @user.first_name = 'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'      
      @user.save

      test_user = User.authenticate_with_credentials('  john@email.com  ', 'password')
      expect(test_user).not_to be(nil)
    end

    it 'should still authenticate with caps in the email' do
      @user = User.new
      @user.first_name = 'john'
      @user.last_name = 'smith'
      @user.email = 'john@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'      
      @user.save

      user = User.authenticate_with_credentials('JoHn@eMAil.com', 'password')
      expect(user).not_to be(nil)
    end

  end

end
