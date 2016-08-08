json.array!(@default_volumes) do |default_volume|
  json.extract! default_volume, :id, :volume, :name
  json.url default_volume_url(default_volume, format: :json)
end
