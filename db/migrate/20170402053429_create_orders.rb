class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :external_id
      t.integer :customers_id

      t.timestamps
    end
  end
end
