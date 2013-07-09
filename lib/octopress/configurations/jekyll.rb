require "octopress/configuration"

module Octopress
  class JekyllConfiguration < Configuration
    def initialize
      configure do |config|
        # If publishing to a subdirectory as in http://site.com/project set root = '/project'
        config.root                 = '/'
        config.permalink            = '/blog/:year/:month/:day/:title/'
        config.source               = 'source'
        config.destination          = 'public'
        config.plugins              = 'plugins'
        config.code_dir             = 'downloads/code'
        config.category_dir         = 'blog/categories'
        config.markdown             = 'rdiscount'
        config.rdiscount.extensions = %w[autolink footnotes smart]
        config.pygments             = false # default python pygments have been replaced by pygments.rb

        config.paginate       = 10          # Posts per page on the blog index
        config.pagination_dir = 'blog'  # Directory base for pagination URLs eg. /blog/page/2/
        config.recent_posts   = 5       # Posts in the sidebar Recent Posts section
        config.excerpt_link   = "Read on &rarr;"  # "Continue reading" link text at the bottom of excerpted articles

        config.titlecase =  true       # Converts page and post titles to titlecase

        # list each of the sidebar modules you want to include, in the order you want them to appear.
        # To add custom asides, create files in /source/_includes/custom/asides/ and add them to the list like 'custom/asides/custom_aside_name.html'
        config.default_asides =  %w[asides/recent_posts.html asides/github.html asides/delicious.html asides/pinboard.html asides/googleplus.html]

        # Each layout uses the default asides, but they can have their own asides instead. Simply uncomment the lines below
        # and add an array with the asides you want to use.
        # blog_index_asides =
        # post_asides =
        # page_asides =
      end
    end
  end
end
