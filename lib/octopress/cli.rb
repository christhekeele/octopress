require 'thor'
require 'pathname'
require 'octopress'
Dir.glob("octopress/commands/**/*.rb").each{ |file| require file }

module Octopress
  class Cli < Thor
    include Thor::Actions

    class << self
      attr_accessor :call_root, :bootfile, :source_root, :in_site
    end

  ####
  # Find a working directory
  ##
    self.call_root = Dir.pwd
    self.source_root = loop do
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
  # Load an Octopress site and relevant tasks or enable site creator
  ##
    if self.in_site
      require self.bootfile
      register Octopress::Commands::Generate, 'generate', 'generate NEW_CONTENT', 'Generate new content.'
    else
      desc 'new NAME', 'Create a new octopress site'
      def new(site_name='octopress')
        puts self.class.call_root, self.class.in_site, self.class.source_root
      end
    end

  end
end
