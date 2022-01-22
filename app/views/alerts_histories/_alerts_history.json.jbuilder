json.extract! alerts_history, :id, :description, :created_at, :updated_at
json.url alerts_history_url(alerts_history, format: :json)
