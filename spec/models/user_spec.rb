require_relative '../spec_helper'

describe User do
  it 'creates a User given valid attributes' do
    joe = FactoryGirl.create(:user)
    expect(joe).to be_valid
  end
end
