# frozen_string_literal: true

require "rest-client"

module Itunes
  class AlbumSearch
    # This service allows you to search within the Itunes Search API for album content

    # Initialize the service with the following params
    #
    # @params [String] the search term(s) to use in the iTunes Search API
    # @option params [String] :country - The two-letter country code for the store you want to search.
    #   The search uses the default store front for the specified country
    def initialize(search, params = {})
      @params = params
      @search = search

      @parsed_response = {}
    end

    # Based on the search term, this service will return all the iTunes albums that match the submitted name
    # and the albums of the artists that match the submitted name.
    #
    # @return Hash - response with the formatted albums and the number of albums returned
    # Hash format: 
    #    {"resultCount"=>[String], "results" => Array[Hash]}
    def call
      return nil if @search.blank?
      
      build_album_response

      resultCount = @parsed_response.present? ? @parsed_response.count : 0 

      { "resultCount": resultCount, "results": @parsed_response }
    rescue StandardError => e
      raise "An error has occurred while trying to get Itunes albuns: #{e.message}" 
    end

    private

    # Builds the album response based on the API calls needed to get all the information about the albuns and the artists
    # related to the search term of the user.
    # Makes the API calls to obtain the album information and formats the results with the relevant information~
    # for the user, by adding the results to the parsed response that will be returned by the service call
    #
    def build_album_response
      album_api_response = Itunes::ApiSearch.new(album_input_params).call
      album_artist_api_resp = Itunes::ApiSearch.new(music_artist_input_params).call

      # album_api_response = JSON.parse(mock_api_empty_response) 
      # album_artist_api_resp = JSON.parse(mock_api_response) 

      parse_album_response(album_api_response)
      parse_album_response(album_artist_api_resp)
    end

    # Parses the response obtained by the Itunes Search API in order to format the albums with the
    # relevant information to be returned to the user
    #
    # return [Hash] - the current album response will receive the new formatted albums
    def parse_album_response(album_api_response)
      return unless album_api_response.present?

      params = { api_response: album_api_response }
      parsed_albums = AlbumParser.new(params).call
      
      @parsed_response = @parsed_response.merge(parsed_albums) if parsed_albums.present?
    end

    # The input params to be used in the ITunes API call to obtain the albuns related to the search term
    #
    # @return Hash - input params to be used in the ITunes API service.
    def album_input_params
      {
        params:
          {
              term: @search,
              country: @params.fetch(:country, "US"),
              entity: "album",
              attribute: "albumTerm",
          },
      }
    end

    # The input params to be used in the ITunes API call to obtain the albuns of the artists related to the search term
    #
    # @return Hash - input params to be used in the ITunes API service
    def music_artist_input_params
      {
        params:
          {
              term: @search,
              country: @params.fetch(:country, "US"),
              entity: "album",
              attribute: "artistTerm",
          },
      }
    end

    def mock_api_response
      {
      "resultCount": 38,
      "results": [
          {
              "wrapperType": "collection",
              "collectionType": "Album",
              "artistId": 487143,
              "collectionId": 1065975633,
              "amgArtistId": 76669,
              "artistName": "Pink Floyd",
              "collectionName": "The Wall",
              "collectionCensoredName": "The Wall",
              "artistViewUrl": "https://music.apple.com/us/artist/pink-floyd/487143?uo=4",
              "collectionViewUrl": "https://music.apple.com/us/album/the-wall/1065975633?uo=4",
              "artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/3c/b4/e3/3cb4e3d0-cd77-8f18-7465-d60e6949b435/886445635850.jpg/60x60bb.jpg",
              "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/3c/b4/e3/3cb4e3d0-cd77-8f18-7465-d60e6949b435/886445635850.jpg/100x100bb.jpg",
              "collectionPrice": 19.99,
              "collectionExplicitness": "notExplicit",
              "trackCount": 27,
              "copyright": "℗ 2016 The copyright in this sound recording is owned by Pink Floyd Music Ltd., marketed and distributed by Sony Music Entertainment",
              "country": "USA",
              "currency": "USD",
              "releaseDate": "1979-11-30T08:00:00Z",
              "primaryGenreName": "Rock"
          },
          {
              "wrapperType": "collection",
              "collectionType": "Album",
              "artistId": 32940,
              "collectionId": 186166282,
              "amgArtistId": 4576,
              "artistName": "Michael Jackson",
              "collectionName": "Off the Wall",
              "collectionCensoredName": "Off the Wall",
              "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Music115/v4/cc/b0/7f/ccb07f0d-1530-00b0-244a-6332daffc2b9/dj.xnuhftrz.jpg/100x100bb.jpg",
              "collectionPrice": 9.99,
              "collectionExplicitness": "notExplicit",
              "trackCount": 10,
              "copyright": "℗ 1979 MJJ Productions Inc.",
              "country": "USA",
              "currency": "USD",
              "releaseDate": "1983-07-04T07:00:00Z",
              "primaryGenreName": "Pop"
          },
          {
              "wrapperType": "collection",
              "collectionType": "Album",
              "artistId": 634287,
              "collectionId": 266809606,
              "amgArtistId": 278369,
              "artistName": "Destiny's Child",
              "collectionName": "The Writing's On the Wall",
              "collectionCensoredName": "The Writing's On the Wall",
              "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/c9/29/74/c92974ce-2bdd-4b86-a261-01adc901bb65/mzi.cmambura.jpg/100x100bb.jpg",
              "collectionPrice": 9.99,
              "collectionExplicitness": "notExplicit",
              "trackCount": 16,
              "copyright": "℗ 1999 SONY BMG MUSIC ENTERTAINMENT",
              "country": "USA",
              "currency": "USD",
              "releaseDate": "1999-07-26T07:00:00Z",
              "primaryGenreName": "R&B/Soul"
          },
        ]
      }.to_json
    end

    def mock_api_empty_response
      {
        "resultCount": 0,
        "results": [],
      }
    end
  end
end