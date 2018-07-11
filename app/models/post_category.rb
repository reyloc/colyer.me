# frozen_string_literal: true

# Defines post_category model
class PostCategory < ApplicationRecord
  belongs_to :post, optional: false
  belongs_to :category, optional: false
end
