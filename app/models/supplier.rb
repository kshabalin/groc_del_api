# == Schema Information
#
# Table name: suppliers
#
#  id          :bigint           not null, primary key
#  name        :string
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Supplier < ApplicationRecord
  belongs_to :category
  has_many :products

  validates :name, presence: true, length: { minimum: 1 }
  validates :category, presence: true
end
