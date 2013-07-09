require "octopress/configuration"
require "octopress/configurations/jekyll"
require "octopress/configurations/third_party"

module Octopress
  class CoreConfiguration < Configuration
    def initialize
      configure do |config|
        config.url           = 'http://yoursite.com'
        config.title         = 'My Octopress Blog'
        config.subtitle      = 'A blogging framework for hackers.'
        config.author        = 'Your Name'
        config.simple_search = 'http://google.com/search'
        config.description   = nil

        # Default date format is "ordinal" (resulting in "July 22nd 2007")
        # You can customize the format as defined in
        # http://www.ruby-doc.org/core-1.9.2/Time.html#method-i-strftime
        # Additionally, %o will give you the ordinal representation of the day
        config.date_format = "ordinal"

        # RSS / Email (optional) subscription links (change if using something like Feedburner)
        config.subscribe_rss   = '/atom.xml'
        config.subscribe_email = nil
        # RSS feeds can list your email address if you like
        config.email = nil

        config.jekyll = Octopress::JekyllConfiguration.new

        config.third_party = Octopress::ThirdPartyConfiguration.new

      end
    end
  end
end
