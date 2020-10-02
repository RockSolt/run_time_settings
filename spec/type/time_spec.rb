# frozen_string_literal: true

RSpec.describe RunTimeSettings::Type::Time do
  let(:type_caster) { described_class.new }

  describe '#deserialize' do
    let(:value) { Time.now }

    it 'converts from string of seconds since epoch' do
      db_value = value.to_i.to_s
      expect(type_caster.deserialize(db_value)).to be_within(1.second).of(value)
    end
  end

  describe '#serialize' do
    let(:value) { Time.now }

    it 'converts to seconds since epoch' do
      expect(type_caster.serialize(value)).to eq value.to_i
    end

    it 'can be converted back with Time.at' do
      expect(Time.at(type_caster.serialize(value))).to be_within(1.second).of(value)
    end
  end
end
