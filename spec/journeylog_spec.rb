require 'journeylog'

describe JourneyLog do 
  let(:journey_instance) {double :journey_instance, start_journey: station, end_journey: station} 
  let(:journey_c) {double :journey_c, new: journey_instance}
  let(:station) {double :station}
  subject {described_class.new(journey_c)}

  describe '#initialization' do 

    it 'new JourneyLog class is instantiated w/ Journey class Obj' do
      expect(subject.journey_class).to eq journey_c
    end 
   
    it 'expects current_journey to create new journey' do
      expect(subject.current_journey).to eq journey_instance
    end 

    it 'expects an empty journey_log array as default' do 
      expect(subject.journey_log).to eq []
      end 
  end

  describe '#start' do 
    it 'starts a journey' do 
      expect(journey_instance).to receive(:start_journey).with(station)
      subject.start(station)
    end 

  describe '#finish' do 
    it 'ends a journey' do 
      expect(journey_instance).to receive(:end_journey).with(station)
      subject.finish(station)
    end 
  end 

  describe '#journeys' do 
    it 'stores journey instance in @journey_log array' do 
      subject.journeys
      expect(subject.journey_log).to include (journey_instance)
    end 
  end 

  describe '#return_journeys' do 
    it 'should return a dup of @journey_log, not log obj itself' do 
      subject.journeys
      expect(subject.return_journeys).to_not eq subject.journey_log
      p subject.journey_log.map  { |obj| obj.object_id }
      p subject.return_journeys.map  { |obj| obj.object_id }
    end 
  end 

  describe '#fare' do
    let(:old_street) {"Old Street"}
    let(:kings_cross) {"Kings Cross"}
    it 'returns the minimum fare if touch in and touch out' do
      subject.start(kings_cross) 
      subject.finish(old_street)
      allow(journey_instance).to receive(:entry_station).and_return (kings_cross)
      allow(journey_instance).to receive(:exit_station).and_return (old_street)
      expect(subject.fare).to eq JourneyLog::MIN_FARE
    end
    it 'returns the penalty fare of 6 if there was no touch in' do
      subject.finish(old_street) 
      allow(journey_instance).to receive(:entry_station).and_return(nil)
      allow(journey_instance).to receive(:exit_station).and_return(old_street)
      expect(subject.fare).to eq JourneyLog::PENALTY_FARE
    end
    it 'returns the penalty fare of 6 if there was no touch out' do
      allow(journey_instance).to receive(:entry_station).and_return(kings_cross)
      subject.start(kings_cross) 
      subject.finish(nil) 
      allow(journey_instance).to receive(:exit_station).and_return(nil)
      expect(subject.fare).to eq JourneyLog::PENALTY_FARE
    end
  end 
 
end 

    # describe '#start' do 
  #   it 'starts a journey' do 
  #     expect(new_journey).to receive(:start).with(station)
  #     subject.start(station)
  #   end 
  # end 
  # let(:station) {double :station}
  # describe '#start' do 
  #   it 'starts a journey' do 
  #     journey = JourneyLog.new(Journey.new)
  #     expect(journey).to respond_to(start)
  #     subject.start(station)
  #   end 
  # end 


end 