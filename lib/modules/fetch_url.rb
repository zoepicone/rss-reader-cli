require 'open-uri'
require 'uri'

module FetchUrl

  # @param uri_str [String]
  # @return [IO, nil]
  def self.read_url(uri_str)
    begin
      if URI.parse(uri_str).kind_of?(URI::HTTP)
        URI.open(uri_str)
      else
        STDERR.puts "Error: Invalid URI!"
        nil
      end
    rescue StandardError
      STDERR.puts "Error: Invalid page!"
      nil
    end
  end
end