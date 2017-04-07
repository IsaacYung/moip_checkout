class ChangeColumnsDiscountType < ActiveRecord::Migration[5.0]
  def change
    change_column :coupons, :discount, :float
  end
end
