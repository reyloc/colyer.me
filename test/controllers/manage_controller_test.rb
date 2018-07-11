# frozen_string_literal: true

require 'test_helper'

class ManageControllerTest < ActionDispatch::IntegrationTest
  test 'should get users' do
    get manage_users_url
    assert_response :success
  end

  test 'should get categories' do
    get manage_categories_url
    assert_response :success
  end

  test 'should get posts' do
    get manage_posts_url
    assert_response :success
  end
end
