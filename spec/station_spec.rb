require 'station'

describe Station do
  subject { described_class.new('Tufnell Park', 2) }

  it 'knows the station name' do
    expect(subject.station).to eq 'Tufnell Park'
  end

  it 'knows the zone' do
    expect(subject.zone).to eq 2
  end
end
