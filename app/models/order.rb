class Order < ApplicationRecord
  has_one :payments
  belongs_to :customers, optional: true
  has_many :product_movements, dependent: :destroy
end
