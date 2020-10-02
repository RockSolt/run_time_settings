# frozen_string_literal: true

#= Configuration Test
#
# Class ConfigurationTest is a PORO that implements PersistentAttributes and declares three sample settings.
class ConfigurationTest
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

RSpec.describe RunTimeSettings do
  it 'has a version number' do
    expect(RunTimeSettings::VERSION).not_to be nil
  end

  describe 'ConfigurationTest class' do
    shared_examples 'returns default' do |name, default|
      it(name.to_s) { expect(ConfigurationTest.public_send(name)).to eq default }
    end

    shared_examples 'reads and writes setting' do |name, default, new_value|
      it_behaves_like 'returns default', name, default

      it "returns updated value for #{name}" do
        ConfigurationTest.public_send("#{name}=", new_value)
        expect(ConfigurationTest.public_send(name)).to eq new_value
      end
    end

    shared_examples 'reads and writes setting without milliseconds' do |name, default, new_value|
      it_behaves_like 'returns default', name, default

      it "returns updated value within 1 second for #{name}" do
        ConfigurationTest.public_send("#{name}=", new_value)
        expect(ConfigurationTest.public_send(name)).to be_within(1.second).of(new_value)
      end
    end

    shared_examples 'adds predicate method' do |name|
      it {       expect(ConfigurationTest).to respond_to("#{name}?") }
    end

    it_behaves_like 'reads and writes setting', :big_integer_with_default, ConfigurationTest::DEFAULT_BIG_INTEGER,
                    987_654_321
    it_behaves_like 'reads and writes setting', :big_integer_no_default, nil, 987_654_321

    it_behaves_like 'reads and writes setting', :boolean_with_default, true, false
    it_behaves_like 'adds predicate method', :boolean_with_default
    it_behaves_like 'reads and writes setting', :boolean_no_default, nil, true
    it_behaves_like 'adds predicate method', :boolean_no_default

    it_behaves_like 'reads and writes setting', :date_with_default, ConfigurationTest::DEFAULT_DATE, Date.tomorrow
    it_behaves_like 'reads and writes setting', :date_no_default, nil, Date.tomorrow

    it_behaves_like 'reads and writes setting without milliseconds', :datetime_with_default,
                    ConfigurationTest::DEFAULT_DATETIME, DateTime.now
    it_behaves_like 'reads and writes setting without milliseconds', :datetime_no_default, nil, DateTime.now

    it_behaves_like 'reads and writes setting', :decimal_with_default, ConfigurationTest::DEFAULT_DECIMAL,
                    BigDecimal('23.45')
    it_behaves_like 'reads and writes setting', :decimal_no_default, nil, BigDecimal('23.45')

    it_behaves_like 'reads and writes setting', :float_with_default, ConfigurationTest::DEFAULT_FLOAT, 11
    it_behaves_like 'reads and writes setting', :float_no_default, nil, 12

    it_behaves_like 'reads and writes setting', :integer_with_default, ConfigurationTest::DEFAULT_INTEGER, 11
    it_behaves_like 'reads and writes setting', :integer_no_default, nil, 12

    it_behaves_like 'reads and writes setting', :string_with_default, ConfigurationTest::DEFAULT_STRING, 'gold'
    it_behaves_like 'reads and writes setting', :string_no_default, nil, 'gold'

    it_behaves_like 'reads and writes setting without milliseconds', :time_with_default,
                    ConfigurationTest::DEFAULT_TIME, Time.now
    it_behaves_like 'reads and writes setting without milliseconds', :time_no_default, nil, Time.now
  end
end
