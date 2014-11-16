module LockUpCollection
  def collection_to_json(spots)
    spots.map{|s| s.to_json_with_photo_url}
  end
end