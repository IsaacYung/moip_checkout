class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.integer :quantity
      t.string :detail
      t.integer :price

      t.timestamps
    end
  end
end
