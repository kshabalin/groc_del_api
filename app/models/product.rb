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

  validates :name, presence: true, length: { minimum: 1 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  validates :category, presence: true
  validates :supplier, presence: true
  validate :supplier_category

  scope :search_by_name, ->(name) { where("products.name ILIKE ?", "%#{name}%") }

  private

  def supplier_category
    errors.add(:category, "Invalid supplier category") if category != supplier&.category
  end
end
