class Album < ApplicationRecord

  validates :album_id, presence: true
  
  # Builds a new album in the database or returns the existing one
  def self.build_album(album_hash, album_id)
    return if album_id.blank? || album_hash.blank?

    # If the album is already in the database, do not build a new album (skip the below block)
    Album.find_or_create_by!(
      album_id: album_id,
      title: album_hash["collectionName"],
      subtitle: album_hash["artistName"], 
      # "artistId": album["artistId"],
      thumbnail: album_hash["artworkUrl100"]
    )
  end
end