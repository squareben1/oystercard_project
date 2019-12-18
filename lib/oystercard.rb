require_relative 'station'
require_relative 'journey'

class Oystercard

attr_reader :balance, :limit, :travelling, :min_balance, :min_fare

LIMIT = 90
MIN_BALANCE = 1
MIN_FARE = 2
PENALTY_FARE = 6

  def initialize(limit=LIMIT, min_fare = MIN_FARE, min_balance = MIN_BALANCE, penalty_fare = PENALTY_FARE, journey=Journey.new)
    @balance = 0
    @limit = limit
    @min_balance = min_balance
    @journey = journey
    @min_fare = min_fare
    @penalty_fare = penalty_fare

  end 

  def top_up(amount)
    fail "ERROR - card already holds max funds (Max = #{@limit}" if (amount + @balance) > @limit
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient Funds" if @balance < @min_balance
    @journey.start_journey(station)
  end 

  def touch_out(station)
    deduct(@min_fare)
    @journey.end_journey(station)
  end 

  def fare 
    if @journey.journey[0][:start] == nil
      PENALTY_FARE
    elsif @journey.journey.count != 0 && @journey.entry_station == nil
      MIN_FARE
    else
      PENALTY_FARE
    end
  end 

  private

  def deduct(amount)
    @balance -= amount
  end 

end 