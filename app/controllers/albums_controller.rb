class AlbumsController < ApplicationController

  before_action :get_search_terms

  # Show the albums returned by the ITunes Search API
  #
  # @search [String] The search term to get the respective albums through the ITunes search API
  #
  # @count [Integer] Number of albuns obtained
  # @albums [JSON] The albums obtained to show to the user
  def show
    return nil if @search.blank?

    search_response = Itunes::AlbumSearch.new(@search).call

    @count = search_response[:resultCount]
    @albums = search_response[:results]

    render :show
  end

  private

  # Gets the search term written by the user in the application
  #
  def get_search_terms
    @search = params.fetch(:search, nil)
  end
end
