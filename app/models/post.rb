class Post < ApplicationRecord
  has_many :post_contents
  has_many :users
  has_many :comments
end
