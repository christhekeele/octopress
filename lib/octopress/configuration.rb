require 'logger'
require 'octopress/extensions/key_path'

module Octopress
  class Configuration

    def self.from_hash(source_hash)
      result = self.new
      key_chains = source_hash.key_paths.to_key_chains
      key_chains.each do |key_chain|
        method_chain = key_chain.dup
        actual_value = method_chain.pop
        object = result
        method_chain.each do |method_name|
          object = object.send method_name
        end
        hash = source_hash
        key_chain.each do |method_name|
          hash = hash[method_name]
        end
        object.send :"#{actual_value}=", hash
      end
      result
    end

    def to_hash
      unless self.instance_variables.empty?
        Hash[
          self.instance_variables.map do |instance_variable_name|
            key = instance_variable_name.to_s.gsub('@', '').to_sym
            value = self.instance_variable_get(instance_variable_name)
            value = value.to_hash if value.is_a?(Configuration)
            [key, value]
          end
        ]
      else
        nil
      end
    end

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
        [ setting_name, :"#{setting_name.to_s.gsub('=','')}" ]
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
