# frozen_string_literal: true

require 'support/configuration'

RSpec.describe RunTimeSettings do
  it 'has a version number' do
    expect(RunTimeSettings::VERSION).not_to be nil
  end

  describe 'PORO with run time settings' do
    let(:model) { Test::Configuration }

    shared_examples 'returns default' do |name, default|
      it(name.to_s) { expect(model.public_send(name)).to eq default }
    end

    shared_examples 'reads and writes setting' do |name, default, new_value|
      it_behaves_like 'returns default', name, default

      it "returns updated value for #{name}" do
        model.public_send("#{name}=", new_value)
        expect(model.public_send(name)).to eq new_value
      end
    end

    shared_examples 'reads and writes setting without milliseconds' do |name, default, new_value|
      it_behaves_like 'returns default', name, default

      it "returns updated value within 1 second for #{name}" do
        model.public_send("#{name}=", new_value)
        expect(model.public_send(name)).to be_within(1.second).of(new_value)
      end
    end

    shared_examples 'adds predicate method' do |name|
      it { expect(model).to respond_to("#{name}?") }
    end

    it_behaves_like 'reads and writes setting', :big_integer_with_default, Test::Configuration::DEFAULT_BIG_INTEGER,
                    987_654_321
    it_behaves_like 'reads and writes setting', :big_integer_no_default, nil, 987_654_321

    it_behaves_like 'reads and writes setting', :boolean_with_default, true, false
    it_behaves_like 'adds predicate method', :boolean_with_default
    it_behaves_like 'reads and writes setting', :boolean_no_default, nil, true
    it_behaves_like 'adds predicate method', :boolean_no_default

    it_behaves_like 'reads and writes setting', :date_with_default, Test::Configuration::DEFAULT_DATE, Date.tomorrow
    it_behaves_like 'reads and writes setting', :date_no_default, nil, Date.tomorrow

    it_behaves_like 'reads and writes setting without milliseconds', :datetime_with_default,
                    Test::Configuration::DEFAULT_DATETIME, DateTime.now
    it_behaves_like 'reads and writes setting without milliseconds', :datetime_no_default, nil, DateTime.now

    it_behaves_like 'reads and writes setting', :decimal_with_default, Test::Configuration::DEFAULT_DECIMAL,
                    BigDecimal('23.45')
    it_behaves_like 'reads and writes setting', :decimal_no_default, nil, BigDecimal('23.45')

    it_behaves_like 'reads and writes setting', :float_with_default, Test::Configuration::DEFAULT_FLOAT, 11
    it_behaves_like 'reads and writes setting', :float_no_default, nil, 12

    it_behaves_like 'reads and writes setting', :integer_with_default, Test::Configuration::DEFAULT_INTEGER, 11
    it_behaves_like 'reads and writes setting', :integer_no_default, nil, 12

    it_behaves_like 'reads and writes setting', :string_with_default, Test::Configuration::DEFAULT_STRING, 'gold'
    it_behaves_like 'reads and writes setting', :string_no_default, nil, 'gold'

    it_behaves_like 'reads and writes setting without milliseconds', :time_with_default,
                    Test::Configuration::DEFAULT_TIME, Time.now
    it_behaves_like 'reads and writes setting without milliseconds', :time_no_default, nil, Time.now
  end
end
