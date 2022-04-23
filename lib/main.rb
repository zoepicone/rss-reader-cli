require './modules/fetch_url'
require './modules/fetch_rss'
require './modules/format_rss'

# Check that URI is provided
unless ARGV.length == 1
  STDERR.puts "Invalid amount of arguments provided."
  exit(false)
end

puts "Reading feed...\n\n"

fetched_url = FetchUrl.read_url(ARGV[0])
exit(false) if fetched_url.nil?

feed = FetchRss.read_feed(fetched_url)
exit(false) if feed.nil?

FormatRss.print_feed_headlines_rss(feed, 10) if feed.class == RSS::Rss
FormatRss.print_feed_headlines_atom(feed, 10) if feed.class == RSS::Atom::Feed

exit(true)