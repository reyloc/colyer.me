# frozen_string_literal: true

# Defines post model
class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories
end
