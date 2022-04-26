# typed: true
require 'sorbet-runtime'
require 'rss'

module FetchRss
  extend T::Sig

  sig{params(feed_url: T.nilable(T.any(Tempfile, StringIO))).returns(T.nilable(T.any(RSS::Rss, RSS::Atom::Feed)))}
  def self.read_feed(feed_url)
    begin
      rss_feed = RSS::Parser.parse(feed_url)
      return rss_feed
    rescue StandardError
      STDERR.puts "Error: RSS feed not found at this location!"
      nil
    end
  end
end