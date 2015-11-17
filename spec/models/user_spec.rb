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
end
