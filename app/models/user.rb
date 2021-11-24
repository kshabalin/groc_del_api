# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :shopping_cart
  has_many :products, through: :shopping_cart

  validates :name, presence: true, length: { minimum: 1 }
  validates :uid, presence: true, length: { minimum: 1 }
end
