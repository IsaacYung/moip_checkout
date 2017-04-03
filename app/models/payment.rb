class Payment < ApplicationRecord
  belongs_to :orders, optional: true
end
