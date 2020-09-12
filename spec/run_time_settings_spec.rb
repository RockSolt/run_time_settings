# frozen_string_literal: true

RSpec.describe RunTimeSettings do
  it 'has a version number' do
    expect(RunTimeSettings::VERSION).not_to be nil
  end
end
