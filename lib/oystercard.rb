require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard

attr_reader :balance, :limit, :travelling, :min_balance

LIMIT = 90
MIN_BALANCE = 1

  def initialize(limit=LIMIT, min_balance = MIN_BALANCE)
    @balance = 0
    @limit = limit
    @min_balance = min_balance
    @journey = JourneyLog.new(Journey)  

  end 

  def top_up(amount)
    fail "ERROR - card already holds max funds (Max = #{@limit}" if (amount + @balance) > @limit
    @balance += amount
  end

  def touch_in(station=nil)
    fail "Insufficient Funds" if @balance < @min_balance
    touch_out if @journey.current_journey.entry_station != nil  
    @journey.start(station) 
  end 

  def touch_out(station=nil)
    @journey.finish(station)  
    deduct(@journey.fare) #journey
    # @journey.reset #should jsut call on journeylog as this takes care of reset 
  end 

  private

  def deduct(amount)
    @balance -= amount
  end 

end 