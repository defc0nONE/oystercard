class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :station_1, :journeys

  def initialize
    @balance = 0
    @station_1 = nil
    @station_2 = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    station_1 != nil
  end

  def touch_in(station_1)
    fail "Sorry, not enough money" if balance < MINIMUM_BALANCE
    @station_1 = station_1
  end

  def touch_out(station_2)
    deduct(MINIMUM_BALANCE)
    @journeys  << {from: station_1, to: station_2}
    @station_1 = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
