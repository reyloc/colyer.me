# frozen_string_literal: true

require 'spec_helper'

describe User, type: :model do
  let(:user) {
    User.new(email: 'test@example.com',
             username: 'test_user',
             full_name: 'Test User',
             password: 'password1',
             admin: 1,
             author: 1)
  }
  it 'saves attributes' do
    result = user.save
    expect(result).to be true
  end
  it 'email should be present' do
    expect(user).to validate_presence_of :email
  end
  it 'username should be present' do
    expect(user).to validate_presence_of :username
  end
end
