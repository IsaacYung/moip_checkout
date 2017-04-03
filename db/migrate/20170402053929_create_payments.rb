class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :external_id
      t.integer :order_id
      t.string :status
      t.json :amount
      t.integer :instalment_count
      t.json :funding_instrument

      t.timestamps
    end
  end
end
