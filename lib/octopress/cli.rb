require 'thor'
require "octopress"

module Octopress
  class Cli < Thor

    desc :new, "Initializes a new Octopress site in the current directory."
    def new(site_name)
      puts site_name
    end

  end
end
