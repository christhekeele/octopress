require "octopress/configuration"

module Octopress
  module Configurable
    def self.included(base)
      class << base
        attr_accessor :configuration, :configuration_klass
      end
      base.instance_variable_set :@configuration_klass, Configuration
      base.extend ClassMethods
    end

    module ClassMethods
      def configure
        self.configuration ||= self.configuration_klass.new
        yield(configuration) if block_given?
        configuration
      end

      def configure_with(klass)
        self.configuration_klass = klass
      end
    end
  end
end
