require 'logger'

module Octopress
  class Configuration

    def configure(&block)
      yield(self) if block_given?
    end

    def method_missing(setting, *args, &block)
      setter, getter = derive_setting_names(setting)
      create_accessors setter, getter
      if setter? setting
        set setter, *args, &block
      else
        set_nested_configuration setter, *args, &block
      end
    end

    protected

    def derive_setting_names(setting_name)
      if setter? setting_name
        [ setting_name, :"#{setting_name.to_s.scan(/.+[^=]/).first}" ]
      else
        [:"#{setting_name}=", setting_name ]
      end
    end

    def setter?(setting)
      setting =~ /=$/
    end

    def create_accessors(setter, getter)
      define_singleton_method setter do |value|
        instance_variable_set :"@#{getter}", value
      end
      define_singleton_method getter do
        instance_variable_get :"@#{getter}"
      end
    end

    def set(setter, *args, &block)
      if block_given?
        send setter, *args, &block
      else
        send setter, *args
      end
    end

    def set_nested_configuration(setter, *args, &block)
      configuration = send setter, Configuration.new
      yield(configuration) if block_given?
      configuration
    end

  end
end
