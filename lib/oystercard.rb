class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :station_1

  def initialize
    @balance = 0
    @station_1 = nil
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    station_1 != nil
  end

  def touch_in(station)
    fail "Sorry, not enough money" if balance < MINIMUM_BALANCE

    @station_1 = station
  end

  def touch_out
    deduct(MINIMUM_BALANCE)

    @station_1 = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
