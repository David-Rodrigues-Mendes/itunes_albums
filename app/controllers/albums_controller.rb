class AlbumsController < ApplicationController

  before_action :get_search_terms

  # Show the albums returned by the ITunes Search API
  #
  # @search [String] The search term to get the respective albums through the ITunes search API
  #
  # return @albums [Array<Album>] The albums obtained to show to the user
  def show
    return nil if @search.blank?

    albumIds = Itunes::AlbumSearch.new(@search).call

    albums = Album.where(album_id: albumIds)
    @albums = albums

    render :show
  end

  # Add the album as the favorite
  #
  # @params [Array<Integer>] The album ids for the search
  # @params [Integer] The album id to add as favorite
  #
  # return @albums [Array<Album>] The albums obtained to show to the user
  def add_favorite
    albumIds = params["albumIds"]
    itunesAlbums = Album.find_by!(album_id: params["album_id"])

    itunesAlbums.update!(favorite: !itunesAlbums.favorite)

    @albums = Album.where(album_id: albumIds)

    render :show
  end

  # Get the favorite albums to show the user
  #
  # return @albums [Array<Album>] The favorite albums to show to the user
  def get_favorites
    @albums = Album.where(favorite: true)

    render :show
  end

  private

  # Gets the search term written by the user in the application
  #
  def get_search_terms
    @search = params.fetch(:search, nil)
  end
end
