class ProductMovement < ApplicationRecord
  belongs_to :orders
  belongs_to :products
end
