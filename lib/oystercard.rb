require_relative 'station'
require_relative 'journey'

class Oystercard

attr_reader :balance, :limit, :travelling, :min_fare

LIMIT = 90
MIN_BALANCE = 1

  def initialize(limit=LIMIT, min_balance = MIN_BALANCE, journey=Journey.new)
    @balance = 0
    @limit = limit
    @min_balance = min_balance
    @journey = journey
    @min_fare = min_fare

  end 

  def top_up(amount)
    fail "ERROR - card already holds max funds (Max = #{@limit}" if (amount + @balance) > @limit
    @balance += amount
  end

  def touch_in(station=nil)
    fail "Insufficient Funds" if @balance < @min_balance
    @journey.start_journey(station)
  end 

  def touch_out(station=nil)
    @journey.end_journey(station)
    deduct(@journey.fare) 
    @journey.reset
    
  end 

  private

  def deduct(amount)
    @balance -= amount
  end 

end 