# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  belongs_to :category
  belongs_to :supplier

  has_many :products
  has_and_belongs_to_many :users

  validates :name, presence: true, length: { minimum: 1 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  validates :category, presence: true
  validates :supplier, presence: true

  scope :search_by_name, ->(name) { where("products.name ILIKE ?", "%#{name}%") }
end
