require_relative 'oystercard'
require_relative 'journey'
require_relative 'journeylog'

class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone 
  end 

end 