json.array!(@contacts) do |contact|
  json.extract! contact, :id, :email, :phone, :name, :active, :birthday, :address, :city, :state, :zipcode
  json.url contact_url(contact, format: :json)
end
