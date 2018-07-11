# frozen_string_literal: true

require 'spec_helper'

describe Post, type: :model do
  let(:post) {
    Post.new(title: 'Test Post',
             user_id: @user.id,
             keywords: 'test,post',
             description: 'test post',
             public: 0)
  }
  before(:context) do
    @user = User.new(email: 'test@example.com',
                     username: 'test_user',
                     full_name: 'Test User',
                     password: 'password1',
                     admin: 1,
                     author: 1)
    @user.save
  end
  after(:context) do
    @user.destroy
  end
  it 'saves attributes' do
    result = post.save!
    expect(result).to be true
  end
  it 'title should be present' do
    expect(post).to validate_presence_of :title
  end
end
