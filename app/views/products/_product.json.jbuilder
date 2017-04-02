json.extract! product, :id, :product_name, :quantity, :detail, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
