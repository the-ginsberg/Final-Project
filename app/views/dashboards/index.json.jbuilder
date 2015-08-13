json.array!(@dashboards) do |dashboard|
  json.extract! dashboard, :id, :title, :calendar, :user_id
  json.url dashboard_url(dashboard, format: :json)
end
