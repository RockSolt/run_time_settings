# frozen_string_literal: true

module Test
  #= Configuration
  #
  # Class Configuration is a PORO that implements PersistentAttributes and declares sample settings for each type.
  class Configuration
    include RunTimeSettings::PersistentAttributes

    DEFAULT_BIG_INTEGER = 123_456_789
    setting :big_integer_with_default, :big_integer, default: DEFAULT_BIG_INTEGER
    setting :big_integer_no_default, :big_integer

    setting :boolean_with_default, :boolean, default: true
    setting :boolean_no_default, :boolean

    DEFAULT_DATE = '1976-07-06'.to_date
    setting :date_with_default, :date, default: DEFAULT_DATE
    setting :date_no_default, :date

    DEFAULT_DATETIME = DateTime.new(2016, 7, 6, 10, 11, 12)
    setting :datetime_with_default, :datetime, default: DEFAULT_DATETIME
    setting :datetime_no_default, :datetime

    DEFAULT_DECIMAL = BigDecimal('12.34')
    setting :decimal_with_default, :decimal, default: DEFAULT_DECIMAL
    setting :decimal_no_default, :decimal

    DEFAULT_FLOAT = 12.34.to_f
    setting :float_with_default, :float, default: DEFAULT_FLOAT
    setting :float_no_default, :float

    DEFAULT_INTEGER = 42
    setting :integer_with_default, :integer, default: DEFAULT_INTEGER
    setting :integer_no_default, :integer

    DEFAULT_STRING = 'blue'
    setting :string_with_default, :string, default: DEFAULT_STRING
    setting :string_no_default, :string

    DEFAULT_TIME = Time.new(2016, 7, 6, 10, 11, 12)
    setting :time_with_default, :time, default: DEFAULT_TIME
    setting :time_no_default, :time
  end
end
