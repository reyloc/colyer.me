# frozen_string_literal: true

# Defines the user model
class User < ApplicationRecord
  has_many :posts
  has_many :comments

  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :full_name, presence: true
  validates :username, :email, presence: true, uniqueness: true

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ['lower(username) = :value OR lower(email) = :value',
       { value: login.strip.downcase }]
    ).first
  end

  def admin?
    self.admin == 1
  end
end
