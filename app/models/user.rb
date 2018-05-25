class User < ApplicationRecord
  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :full_name, presence: true

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end
end
