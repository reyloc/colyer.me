class Post < ApplicationRecord
  has_many :post_contents
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
end
