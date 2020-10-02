# frozen_string_literal: true

require 'active_support'
require 'run_time_settings/type/time'

module RunTimeSettings
  # = Persistent Attributes
  module PersistentAttributes
    extend ActiveSupport::Concern

    class_methods do
      # Specifies a class-level, persistent attribute. The class (not the
      # instance) receives getter and setter methods for the setting.
      # Additionally, boolean settings add predicate methods.
      #
      # +setting_name+ The name of the setting.
      #
      # +type+ A symbol such as +:string+ or +:integer+, or a type object to be
      # used for this attribute. See ActiveModel::Type for list of symbols /
      # delivered types.
      #
      # === Options
      # The following options are accepted:
      #
      # +default+ The default value to use when no value is provided.
      #
      # When using a symbol for +cast_type+, extra options are forwarded to the
      # constructor of the type object.
      #
      # === Examples
      #
      # A BatchJob class declares <tt>setting :last_run, :date</tt>, which will
      # add the following:
      # * <tt>BatchJob.last_run</tt>
      # * <tt>BatchJob.last_run=(date)</tt>
      #
      # A BatchJob class declares <tt>setting :enabled, :boolean, default: false</tt>,
      # which will add the following:
      # * <tt>BatchJob.enabled</tt>
      # * <tt>BatchJob.enabled=(boolean)</tt>
      # * <tt>BatchJob.enabled?</tt>
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
