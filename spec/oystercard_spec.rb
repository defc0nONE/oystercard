require 'oystercard'

describe Oystercard do
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

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts money from card' do
      expect { subject.deduct 1 }.to change { subject.balance }.by(-1)
    end
  end
  describe '#in_journey?' do
    it 'remenber that the user is travelling' do
      expect(subject.in_journey?).to eq false
    end
  end
  describe '#touch_in' do
   it 'recognize when we touch_in with the card' do
     expect(subject.touch_in).to eq true
   end
  end
  describe '#touch_out' do
    it 'recognize when we touch_out with the card' do
    expect(subject.touch_out).to eq true
    end
  end
end
