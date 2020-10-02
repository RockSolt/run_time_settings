# frozen_string_literal: true

require 'active_support'
require 'run_time_settings/type/time'

module RunTimeSettings
  # = Persistent Attributes
  module PersistentAttributes
    extend ActiveSupport::Concern

    class_methods do
      def setting(setting_name, type = ActiveModel::Type::Value.new, **options)
        setting_name = setting_name.to_s
        type = RunTimeSettings::Type::Time.new if type == :time
        type = ActiveModel::Type.lookup(type, **options.except(:default)) if type.is_a?(Symbol)

        RunTimeSettings::Settings.add_setting_type(name, setting_name, type)
        define_setting_accessors(setting_name, options[:default], type.is_a?(ActiveModel::Type::Boolean))
      end

      private

      def define_setting_accessors(setting_name, default, boolean)
        define_singleton_method(setting_name) do
          value = RunTimeSettings::Settings.read(name, setting_name)
          value.nil? ? default : value
        end

        define_singleton_method("#{setting_name}?") { public_send(setting_name) } if boolean

        define_singleton_method("#{setting_name}=") do |value|
          RunTimeSettings::Settings.write(name, setting_name, value)
        end
      end
    end
  end
end
