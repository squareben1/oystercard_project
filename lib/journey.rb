require_relative 'station'
require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :journey, :min_balance, :min_fare, :penalty_fare

  MIN_FARE = 2
  PENALTY_FARE = 6

  def initialize 
    @entry_station = nil 
    @exit_station = nil 
    @journey = [] 
  end 

  def start_journey(station)
    @entry_station = station 
  end 

  def end_journey(station)
    @exit_station = station 
    store_journey 
  end 

  def fare 
    if @entry_station == nil || @exit_station == nil 
      PENALTY_FARE
    else 
      MIN_FARE
    end 
  end 

  def reset
    @entry_station = nil
    @exit_station = nil 
  end 

  def in_journey? 
    # return true unless @entry_station == nil 
    !!entry_station
  end 

  def store_journey 
    @journey << {:start => @entry_station, :finish => @exit_station} 
  end 

  

end 