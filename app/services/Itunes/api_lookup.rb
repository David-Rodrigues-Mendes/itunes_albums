# frozen_string_literal: true

require "rest-client"

module Itunes
  class ApiLookup
    # This service calls the Itunes Lookup API with the params sent as input
    # and returns the result of the API Call

    ITUNES_LOOKUP_API = "https://itunes.apple.com/lookup?"

    # Initialize the service with the following params
    #
    # @params [String] input_params - the search term(s) to use in the iTunes Search API
    def initialize(input_params)
      @input_params = input_params
    end

    # Calls the ITunes Lookup API with the params sent as an input
    #
    # @params [Hash] input_params - the params to be sent to the ITunes Lookup API
    #
    # @return [Hash, nil] The response of the API call if Itunes returns success. Otherwise returns nil
    # Hash format: 
    #    {"resultCount"=>[String], "results" => Array[Hash]}
    def call
      return if @input_params.blank?

      puts "begin api response", Time.now
      api_response = RestClient.get(ITUNES_LOOKUP_API, @input_params)
      puts "end api response", Time.now

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