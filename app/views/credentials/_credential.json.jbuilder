json.extract! credential, :id, :api_name, :api_key, :api_secret, :created_at, :updated_at
json.url credential_url(credential, format: :json)
