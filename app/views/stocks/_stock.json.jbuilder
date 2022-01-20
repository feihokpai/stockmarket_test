json.extract! stock, :id, :symbol, :price, :wallet_id, :created_at, :updated_at
json.url stock_url(stock, format: :json)
