require 'rss'

module FetchRss

  # @param feed_url [IO]
  # @return [RSS::Rss, RSS::Atom::Feed, nil]
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