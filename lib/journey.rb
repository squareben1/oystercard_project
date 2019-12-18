require_relative 'station'
require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :journey

  def initialize 
    @entry_station = nil 
    @exit_station = nil 
    @journey = [] 
    # @complete = nil 
  end 

  def start_journey(station)
    @entry_station = station 
  end 

  def end_journey(station)
    @exit_station = station 
    # @complete = true
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

end 