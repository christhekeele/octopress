require 'thor'
require 'pathname'
require 'octopress'
require 'octopress/commands/generate'

module Octopress
  class Cli < Thor
    include Thor::Actions

    class << self
      attr_accessor :source_root, :call_root, :destination_root
      attr_accessor :bootfile, :in_site
      attr_accessor :site_name
    end
    self.source_root = File.absolute_path(File.dirname __FILE__)

  no_commands do
    def site_name
      @site_name ||= self.class.site_name
    end
  end

  ####
  # Find a working directory
  ##
    self.call_root = Dir.pwd
    self.destination_root = loop do
      bootfile = Dir.pwd + '/config/boot.rb'
      if File.exists?(bootfile) and File.read(bootfile).include?('Octopress.initialize!')
        self.in_site = true
        self.bootfile = bootfile
        break Dir.pwd
      elsif not Pathname.new(Dir.pwd).root?
        Dir.chdir('..')
      else
        break self.call_root
      end
    end
    Dir.chdir(self.call_root)

  ####
  # Load Octopress site
  ##
    if self.in_site
      require self.bootfile
      self.site_name = File.basename(self.destination_root)
    end

  ####
  # Configure tasks
  ##
    if self.in_site
      register Octopress::Commands::Generate, 'generate', 'generate NEW_CONTENT', 'Generate new content.'
    else
      desc 'new NAME', 'Create a new octopress site'
      def new(site_name='octopress')
        self.class.site_name = site_name
        directory 'templates/site', site_name, site_name: site_name
      end
    end

  end
end
