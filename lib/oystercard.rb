class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @journey_status = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @journey_status
  end

  def touch_in
    fail "Sorry, not enough money" if balance < MINIMUM_BALANCE
    @journey_status = true
  end

  def touch_out
    @journey_status = false
  end
end
