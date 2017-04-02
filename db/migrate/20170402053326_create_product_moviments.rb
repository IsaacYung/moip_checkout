class CreateProductMoviments < ActiveRecord::Migration[5.0]
  def change
    create_table :product_moviments do |t|
      t.integer :products_id
      t.integer :orders_id
      t.integer :quantity
      t.string :status

      t.timestamps
    end
  end
end
