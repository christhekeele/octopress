require "octopress/configuration"

module Octopress
  class ThirdPartyConfiguration < Configuration
    def initialize
      configure do |config|
        # Github repositories
        config.github.user              = nil
        config.github.repo_count        = 0
        config.github.show_profile_link = true
        config.github.skip_forks        = true

        # Twitter
        config.twitter.user         = nil
        config.twitter.tweet_button = true

        # Google +1
        config.google_plus_one.active      = false
        config.google_plus_one.size = :medium

        # Google Plus Profile
        # Hidden =  No visible button, just add author information to search results
        config.googleplus.user   = nil
        config.googleplus.hidden = false

        # Pinboard
        config.pinboard.user  = nil
        config.pinboard.count =  3

        # Delicious
        config.delicious.user  = nil
        config.delicious.count = 3

        # Disqus Comments
        config.disqus.short_name         = nil
        config.disqus.show_comment_count = false

        # Google Analytics
        config.google_analytics.tracking_id = nil

        # Facebook Like
        config.facebook.like = false
      end
    end
  end
end
