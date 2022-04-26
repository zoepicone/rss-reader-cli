# typed: true
require 'sorbet-runtime'
require 'colorize'

module FormatRss
  extend T::Sig

  sig {params(feed: RSS::Rss, count: Integer).returns(NilClass)}
  def self.print_feed_headlines_rss(feed, count)
    begin
      puts "#{feed.channel.title.to_str.bold} - #{feed.channel.link.to_str.blue}\n\n"

      feed.items.first(count).each do |item|
        puts "  #{item.title}\n" +
             "    #{item.description.to_str.gsub(/<\/?[^>]*>/, "").light_black}\n" + # strip html tags
             "    Read more: #{item.link.to_str.blue}\n\n"
      end

      nil
    rescue StandardError
      STDERR.puts "Error: Feed is not RSS!"
      exit(false)
    end
  end

  sig {params(feed: RSS::Atom::Feed, count: Integer).returns(NilClass)}
  def self.print_feed_headlines_atom(feed, count)
    begin
      puts "#{feed.title.content.bold}\n\n"

      feed.items.first(count).each do |item|
        puts "  #{item.title.content}\n" +
             "    #{item.content.content.gsub(/<\/?[^>]*>/, "").light_black}\n" + # strip html tags
             "    Read more: #{item.link.href.to_str.blue}\n\n"
      end

      nil
    rescue StandardError
      STDERR.puts "Error: Feed is not Atom or cannot parse contents!"
      exit(false)
    end
  end
end