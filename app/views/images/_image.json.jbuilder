json.extract! image, :id, :image_id, :status_id, :image_title, :image_owner_id, :category_id, :licensing, :date, :description, :file_type, :location, :created_at, :updated_at
json.url image_url(image, format: :json)
