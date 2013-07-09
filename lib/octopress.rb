require "octopress/configuration"
require "octopress/configurations/core"
require "octopress/configurable"

module Octopress
  class << self
    attr_accessor :root
  end
  define_singleton_method :initialize! do |root_path|
    self.root = root_path
  end

  include Configurable
  configure_with CoreConfiguration
end

require "octopress/version"

require 'pry'; binding.pry
