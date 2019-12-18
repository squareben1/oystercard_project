
class Oystercard

attr_reader :balance, :limit, :travelling, :min_balance, :entry_station, :exit_station, :journey

LIMIT = 90
MIN_BALANCE = 1


  def initialize(limit=LIMIT, min_balance = MIN_BALANCE)
    @balance = 0
    @limit = limit
    @min_balance = min_balance
    @entry_station = nil
    @exit_station = nil 
    @journey = []
  end 

  def top_up(amount)
    fail "ERROR - card already holds max funds (Max = #{@limit}" if (amount + @balance) > @limit
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient Funds" if @balance < @min_balance
    @entry_station = station

  end 

  def touch_out(station)
    deduct(@min_balance)
    @exit_station = station
    store_journey
    @entry_station = nil
  end 

  def in_journey?
    # return true unless @entry_station == nil 
    !!entry_station
  end 

  def store_journey
    @journey << {:start => @entry_station, :finish => @exit_station}
  end 

  private

  def deduct(amount)
    @balance -= amount
  end 

end 