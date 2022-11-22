require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    #will make all valid tests pass
      it "valid sign up" do
        @user = User.new(
          first_name: 'test', 
          last_name: 'test', 
          password: 'test123',
          password_confirmation: 'test123', 
          email: 'test@hotmail.com'
        )

        expect(@user).to be_valid
      end

      it "invalid : last_name nil" do
        @user = User.new(
          first_name: 'test', 
          last_name: nil, 
          password: 'test',
          password_confirmation: 'test', 
          email: 'test@hotmail.com'
        )

        expect(@user.errors.full_messages[0] == "first_name can't be blank")
        expect(@user).to_not be_valid
      end

      it "invalid : first_name nil" do
        @user = User.new(
          first_name: nil, 
          last_name: 'test', 
          password: 'test',
          password_confirmation: 'test', 
          email: 'test@hotmail.com'
        )

        expect(@user.errors.full_messages[0] == "last_name can't be blank")
        expect(@user).to_not be_valid
      end

      it "invalid : passwords" do
        @user = User.create(first_name: 'test', last_name: 'test', password: nil, password_confirmation: 'test', email: 'test@hotmail.com')


        expect(@user.errors.full_messages[0] == "password can't be blank")
        expect(@user).to_not be_valid
      end

      it "invalid : pass_confirm nil" do
        @user = User.create(first_name: 'test', last_name: 'test', password: 'test', password_confirmation: nil, email: 'test@hotmail.com')

        expect(@user.errors.full_messages[0] == "password_confirmation can't be blank")
        expect(@user).to_not be_valid
      end

      it "invalid : email nil" do
        @user = User.create(first_name: 'test', last_name: 'test', password: 'test', password_confirmation: 'test', email: nil)

        expect(@user.errors.full_messages[0] == "email can't be blank")
        expect(@user).to_not be_valid
      end
      
      it "invalid : email taken" do
        @user1 = User.create(first_name: 'test1', last_name: 'test1', password: 'test', password_confirmation: 'test', email: 'test@hotmail.com')
        @user2 = User.create(first_name: 'test2', last_name: 'test2', password: 'test', password_confirmation: 'test', email: 'test@hotmail.com')

      
        expect(@user2.errors.full_messages[0] == "Email has already been taken")
        expect(@user2).to_not be_valid
      end

    it "invalid : no matching passes" do
      @user = User.create(first_name: 'test', last_name: 'test', password: 'test', password_confirmation: 'test123', email: 'test@hotmail.com')

      expect(@user.errors.full_messages[0] == "Password Confirmation doesn't match Password")
      expect(@user).to_not be_valid
    end

    it "invalid : password minumum length 5" do
      @user = User.create(first_name: 'test', last_name: 'test', password: 'test', password_confirmation: 'test', email: 'test@hotmail.com')
      expect(@user.errors.full_messages[0] == "Password must be 5 characters minimum")
      expect(@user).to_not be_valid
    end

    end

    describe '.authenticate_with_credentials' do
      it "is valid : email is in db and password matches" do
        @user = User.create(first_name: 'test', last_name: 'test', password: 'test1', password_confirmation: 'test1', email: 'testing')
        @authenticate = User.authenticate_with_credentials('testing', 'test1')
  
        expect(@authenticate).to eql(@user)
      end
  
      it "is valid : email is correct , with whitespace and password matches" do
        @user = User.create(first_name: 'test', last_name: 'test', password: 'test1', password_confirmation: 'test1', email: 'testing')
        @authenticate = User.authenticate_with_credentials(' TeStInG   ', 'test1')
  
        expect(@authenticate).to eql(@user)
  
      end
  
      it "is invalid : user input for email is nil" do
        @user = User.create(first_name: 'test', last_name: 'test', password: 'test1', password_confirmation: 'test1', email: 'testing')
        @authenticate = User.authenticate_with_credentials(nil, 'test1')
  
        expect(@authenticate).to eql(nil)
      end
  
      it "is invalid : user input for password is nil" do
        @user = User.create(first_name: 'test', last_name: 'test', password: 'test1', password_confirmation: 'test1', email: 'testing')
        @authenticate = User.authenticate_with_credentials('test', nil)
  
        expect(@authenticate).to eql(nil)
      end

      it "is valid : user inputs email (case insensitive)" do
        @user = User.create(first_name: 'test', last_name: 'test', password: 'test1', password_confirmation: 'test1', email: 'testing')
        @authenticate = User.authenticate_with_credentials('tesTIng', 'test1')
  
        expect(@authenticate).to eql(@user)
      end
  
      it "is invalid : user inputs wrong password (case sensitive) " do
        @user = User.create(first_name: 'test', last_name: 'test', password: 'test1', password_confirmation: 'test1', email: 'testing')
        @authenticate = User.authenticate_with_credentials('testing', 'Test1')
  
        expect(@authenticate).to eql(nil)
      end
  
    end



end
