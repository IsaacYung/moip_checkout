class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :external_id
      t.string :fullname
      t.string :email
      t.json :phone
      t.date :birth_date
      t.string :tax_document

      t.timestamps
    end
  end
end
