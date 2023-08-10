class Album < ApplicationRecord

  validates :album_id, presence: true
  
  # Builds a new album in the database or returns the existing one
  def self.build_album(album_id)
    return if album_id.blank?

    album = Album.find_or_create_by!(album_id: album_id)
  end
end
