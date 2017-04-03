class ProductMovement < ApplicationRecord
  belongs_to :orders, optional: true
  belongs_to :products, optional: true
end
