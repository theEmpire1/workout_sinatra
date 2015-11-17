require_relative '../spec_helper'

describe User do
  it 'creates a User given valid attributes' do
    joe = FactoryGirl.create(:user)
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
end
