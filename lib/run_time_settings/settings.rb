# frozen_string_literal: true

require 'active_record'

module RunTimeSettings
  # Settings
  #
  # Model settings holds namespaced key-value pairs.
  class Settings < ActiveRecord::Base
    self.table_name = :run_time_settings

    class << self
      def add_setting_type(namespace, key, type)
        setting_types[[namespace, key]] = type
      end

      def read(namespace, key)
        value = RunTimeSettings::Settings.find_by(namespace: namespace, key_name: key)&.db_value
        type_for(namespace, key).deserialize(value) if value.present?
      end

      def write(namespace, key, value)
        setting = RunTimeSettings::Settings.find_or_initialize_by(namespace: namespace, key_name: key)
        setting.update!(db_value: type_for(namespace, key).serialize(value))
      end

      private

      def type_for(namespace, key)
        setting_types[[namespace, key]]
      end

      def setting_types
        @setting_types ||= {}
      end
    end
  end
end
