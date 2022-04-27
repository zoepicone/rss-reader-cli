# typed: true
require 'sorbet-runtime'
require 'open-uri'
require 'uri'
require 'tempfile'

module FetchUrl
  extend T::Sig

  sig{params(uri_str: String).returns(T.nilable(T.any(Tempfile, StringIO)))}
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
