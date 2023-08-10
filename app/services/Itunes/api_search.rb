# frozen_string_literal: true

require "rest-client"

module Itunes
  class ApiSearch
    # This service calls the Itunes Search API with the params sent as input
    # and returns the result of the API Call

    ITUNES_SEARCH_API = "https://itunes.apple.com/search?"

    # Initialize the service with the following params
    #
    # @params [String] input_params - the search term(s) to use in the iTunes Search API
    def initialize(input_params)
      @input_params = input_params
    end

    # Calls the ITunes Search API with the params sent as an input
    #
    # @params [Hash] input_params - the params to be sent to the ITunes Search API
    #
    # @return [Hash, nil] The response of the API call if Itunes returns success. Otherwise returns nil
    # Hash format: 
    #    {"resultCount"=>[String], "results" => Array[Hash]}
    def call
      return if @input_params.blank?

      api_response = RestClient.get(ITUNES_SEARCH_API, @input_params)
      
      JSON.parse(api_response.body) if api_response.code == 200
    rescue RestClient::ExceptionWithResponse => e
      case e.http_code
      when 429
        puts "Rate limit reached for itunes API call. Please wait some minutes before searching again."
      else
        puts "Error: #{e.message}"
      end
    end
      
  end
end