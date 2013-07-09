require "octopress/configuration"
require "octopress/configurations/core"
require "octopress/configurable"

module Octopress
  include Configurable
  configure_with CoreConfiguration
end

require "octopress/version"
