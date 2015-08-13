json.array!(@documents) do |document|
  json.extract! document, :id, :title, :attachment, :dashboard_id, :dashboard_id
  json.url document_url(document, format: :json)
end
