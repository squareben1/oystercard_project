
class JourneyLog

  attr_reader :journey_class, :current_journey, :journey_log, :min_fare, :penalty_fare

  MIN_FARE = 2
  PENALTY_FARE = 6

  def initialize(journey_class )
    @journey_class = journey_class
    current_journey
    @journey_log = []
  end 

  def start(station)
    current_journey.start_journey(station)
  end 

  def finish(station)
    current_journey.end_journey(station) 
    journeys
  end 

  def fare 
    if @journey_log[-1].entry_station == nil || @journey_log[-1].exit_station == nil 
      PENALTY_FARE
    else 
      MIN_FARE
    end 
  end 

  def current_journey 
    @current_journey ||= @journey_class.new
  end 

  def journeys
    @journey_log << current_journey
    @current_journey = nil
  end 

  def return_journeys
    @journey_log.map { |obj| obj.clone } 
  end 

end 