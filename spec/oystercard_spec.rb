require 'oystercard'

describe Oystercard do
  let(:station_1) { double :station_1 }
  let(:station_2) { double :station_2 }

  describe '#balance' do
    it 'checks that a new card has a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance by 1' do
      expect { subject.top_up 1 }.to change { subject.balance }.by(1)
    end

    it 'returns error if top up amount exceeds maximum balance' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      message = "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error message
    end
  end

  describe '#in_journey?' do
    it 'checks the initial state is false' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'recognize when we touch_in with the card' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station_1)
      expect(subject).to be_in_journey
    end

    it 'checks we have minimum amount for our journey' do
      expect { subject.touch_in(station_1) }.to raise_error 'Sorry, not enough money'
    end

    it 'remembers the entry station' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station_1)
      expect(subject.starting_station).to be station_1
    end
  end

  describe '#touch_out' do
    before(:each) do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station_1)
    end

    it 'recognize when we touch_out with the card' do
      subject.touch_out(station_2)
      expect(subject).not_to be_in_journey
    end

    it 'deducts the fare when we touch out' do
      expect { subject.touch_out(station_2) }.to change { subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'forgets the entry station' do
      subject.touch_out(station_2)
      expect(subject.starting_station).to eq nil
    end

    it 'records a train journey' do
      subject.touch_out(station_2)
      expect(subject.journeys).to match_array([{ from: station_1, to: station_2 }])
    end

  end
end
