class CreateProductMovements < ActiveRecord::Migration[5.0]
  def change
    create_table :product_movements do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :quantity
      t.string :status

      t.timestamps
    end
  end
end
