class Order < ApplicationRecord
  has_many :product_movements, dependent: :destroy
  has_one :payments
end
