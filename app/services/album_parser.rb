# frozen_string_literal: true

class AlbumParser

  # Initialize the service with the following params
  #
  # params [Json] album response - the api response with the albums to be parsed
  def initialize(params)
    @params = params

    @api_response = params.fetch(:api_response, {})
  end
    
  # This service will format the albums to send to the controller, as well as inserting the records in the database
  # for the "favorites" functionality 
  def call
    return {} if @api_response.blank?

    add_albums_to_response
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  private

  #
  #
  #
  def add_albums_to_response
    # check if results is an array
    parsed_albums = {}
    albums = @api_response["results"]

    if albums.present?
      albums.each_with_object({}) do |album|
        parsed_albums = parsed_albums.merge(build_album_response(album))
      end
    end

    parsed_albums
  end

 #
 #
 #
  def build_album_response(album)
    albumId = album["collectionId"]
    return unless album["collectionType"] == "Album" && albumId.present?

    {
      albumId => {
        "albumId": albumId,
        "albumName": album["collectionName"],
        "artistId": album["artistId"],
        "artistName": album["artistName"],
        "thumbnail": album["artworkUrl100"],
        "favorite": get_favorite_state(albumId),
      },
    }
  end

  # Gets the "favorite" state of the album, if it exists in the database
  # If not, inserts the album id record in the database and re
  #
  # return [Boolean] the "favorite" state of the album
  def get_favorite_state(albumId)
    album = Album.find_by(album_id: albumId)

    if album.present? 
      album.favorite
    else 
      Album.build_album(albumId)
      false
    end
  end
end
