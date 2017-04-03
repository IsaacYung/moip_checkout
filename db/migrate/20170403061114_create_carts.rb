class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.json :products

      t.timestamps
    end
  end
end
