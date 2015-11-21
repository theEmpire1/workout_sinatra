require_relative '../spec_helper'

describe User do
  it 'creates a User given valid attributes' do
    joe = FactoryGirl.build(:user)
    expect(joe).to be_valid
  end

  it 'does not pass validation unless name is present' do
    not_joe = FactoryGirl.build(:user, name: '    ')
    expect(not_joe).not_to be_valid
  end

  it 'does not pass validation unless email is present' do
    no_email_joe = FactoryGirl.build(:user, email: '    ')
    expect(no_email_joe).not_to be_valid
  end

  it 'restricts user.name to 50 characters' do
    long_name = 'joe' + ('e' * 48)
    long_joe = FactoryGirl.build(:user, name: long_name)
    expect(long_joe).not_to be_valid
  end

  it 'restricts user.email to 250 characters' do
    long_email = 'a' * 251 + '@email.com'
    long_email_joe = FactoryGirl.build(:user, email: long_email)
    expect(long_email_joe).not_to be_valid
  end

  it 'accepts valid email addresses' do
    valid_addresses = %w(
      joe@email.com
      JOE@email.com
      A_JOE_MAN@email.address.com
      joe+shmoe@bar.gov)
    users = []
    valid_addresses.each do |addr|
      users << FactoryGirl.build(:user, email: addr)
    end

    users.each do |u|
      expect(u).to be_valid
    end
  end

  it 'does not accept invalid email addresses' do
    invalid_addresses = %w(
      user@example,com
      user_at_foo.org
      user.name@example.
      foo@bar_baz.com
      foo@bar+baz.com)
    invalid_users = []
    invalid_addresses.each do |addr|
      invalid_users << FactoryGirl.build(:user, email: addr)
    end

    invalid_users.each do |u|
      expect(u).not_to be_valid
    end
  end

  it 'requires email addresses to be unique' do
    FactoryGirl.create(:user, email: 'original@email.com')
    duplicate = FactoryGirl.build(:user, email: 'original@email.com'.upcase)
    expect(duplicate).not_to be_valid
  end

  it 'requires that the password not be blank' do
    no_pass_joe = FactoryGirl.build(:user, password_confirmation: '  ')
    expect(no_pass_joe).not_to be_valid
  end

  it 'requires that the password be at least 6 characters' do
    short_pass_joe = FactoryGirl.build(:user, password_confirmation: 'abc')
    expect(short_pass_joe).not_to be_valid
  end

  describe 'creating a user' do
    it 'creates a new user given valid params' do
      user_args = FactoryGirl.attributes_for(:user)
      expect do
        User.new(user_args).save!
      end.not_to raise_error
    end

    it 'does not create user given invalid params' do
      invalid_user_params = {
        name: 'joe',
        email: 'email@email.com',
        password: 'password',
        password_confirmation: 'notpassword'
      }
      user_args = FactoryGirl.attributes_for(:user, invalid_user_params)
      expect do
        User.new(user_args).save!
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
