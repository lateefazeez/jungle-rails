require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context 'password and password_confirmation' do
      it 'should return true if both fields are equal' do
        @user = User.new({first_name:'Lateef', last_name: 'Azeez', email:'email@gmail.com', password:'password', password_confirmation: 'password'})
        expect(@user.save).to be true
      end

      it 'should return false if both field are not equal' do
        @user = User.new({first_name:'Lateef', last_name: 'Azeez', email:'email@gmail.com', password:'passwordone', password_confirmation: 'passwordtwo'})
        expect(@user.save).to be false
      end

      it 'should return false when either password is not present' do
        @user = User.new({first_name:'Lateef', last_name: 'Azeez', email:'email@gmail.com', password_confirmation: 'passwordtwo'})
        expect(@user.save).to be false
      end

      it 'should have minimum length of 4' do
        @user = User.new({first_name:'Lateef', last_name: 'Azeez', email:'email@gmail.com', password:'aaa', password_confirmation: 'aaa'})
        expect(@user.save).to be false
      end
    end

    context 'first_name, last_name and email must be present' do
      it 'should return false if email field is not present' do
        @user = User.new({first_name:'Lateef', last_name: 'Azeez', password:'passwordone', password_confirmation: 'passwordtwo'})
        expect(@user.save).to be false
      end

      it 'should return false if first_name is not present' do
        @user = User.new({last_name: 'Azeez', email:'email@gmail.com', password:'passwordone', password_confirmation: 'passwordtwo'})
        expect(@user.save).to be false
      end

      it 'should return false if last name is not present' do
        @user = User.new({first_name:'Lateef', email:'email@gmail.com', password:'passwordone', password_confirmation: 'passwordtwo'})
        expect(@user.save).to be false
      end
    end

    context 'email must be unique and not case sensitive' do
      it 'should return false if email is duplicated' do
        @user = User.new({first_name:'Lateef', last_name: 'Azeez', email:'email@gmail.com', password:'password', password_confirmation: 'password'})
        @user.save

        @user2 = User.new({first_name:'first', last_name: 'last', email:'email@gmail.com', password:'password', password_confirmation: 'password'})
        expect(@user2.save).to be false
      end

      it 'should return false if email is not case sensitive' do
        @user = User.new({first_name:'first', last_name: 'last', email:'EMAIL@GMAIL.com', password:'password', password_confirmation: 'password'})
        @user.save
        
        @user2 = User.new({first_name:'Lateef', last_name: 'Azeez', email:'email@gmail.com', password:'password', password_confirmation: 'password'})
        expect(@user2.save).to be false
      end
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.new({first_name:'Lateef', last_name: 'Azeez', email:'email@gmail.com', password:'password', password_confirmation: 'password'})
      @user.save!
    end
    
    it 'should login with correct credentials' do
      user = User.authenticate_with_credentials('email@gmail.com','password')
      expect(user).not_to be nil
    end
    
    it 'should not login with incorrect credentials' do
      user = User.authenticate_with_credentials('email@gmail.com','password1')
      expect(user).to be nil
    end

    it 'should login if there is spaces before or after the email' do
      user = User.authenticate_with_credentials(' email@gmail.com ','password')
      expect(user).not_to be nil
    end

    it 'should login if there is wrong case for the email' do
      user = User.authenticate_with_credentials('Email@GMAIL.com','password')
      expect(user).not_to be nil
    end
  end
end
