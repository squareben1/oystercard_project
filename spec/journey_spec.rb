require 'journey'
# require_relative 'oystercard'

describe Journey do 
  describe '#initialization' do 
    it 'expects an empty array as default' do 
    expect(subject.journey).to eq []
    end 
  end 

  let(:station) {double :station}
  describe '#start_journey' do 
    it 'stores entry_station' do 
      subject.start_journey(station)
      expect(subject.entry_station).to eq station
    end 
  end 
  
  describe '#end_journey' do 
    it 'forgets station on touch_out' do 
      subject.start_journey(station)
      subject.reset
      expect(subject.entry_station).to eq nil
    end
  end 

  describe '#in_journey?' do 
    it 'should be false when @entry_station eq nil' do
      expect(subject.in_journey?).to be_falsey
      end 
    it 'should be true when entry_station eq a station' do
      subject.start_journey(station)
      expect(subject.in_journey?).to be_truthy
    end 
  end 

  let(:start) {double :start} 
  let(:finish) {double :finish}
  describe '#store_journey' do 
    it 'should store the list of journeys in a hash' do 
      subject.start_journey(start)
      subject.end_journey(finish)
      expect(subject.journey).to include ({:start => start, :finish => finish})
    end 
  end 

  describe '#fare' do
    let(:old_street) {"Old Street"}
    let(:kings_cross) {"Kings Cross"}
    it 'returns the minimum fare if touch in and touch out' do
      subject.start_journey(kings_cross)
      subject.end_journey(old_street)
      expect(subject.fare).to eq Journey::MIN_FARE
    end
    it 'returns the penalty fare of 6 if there was no touch in' do
      subject.end_journey(old_street)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    it 'returns the penalty fare of 6 if there was no touch out' do
      subject.start_journey(kings_cross)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end 
end 