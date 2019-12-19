require 'oystercard'
require 'journey'

describe Oystercard do 
  describe '#initialization' do 
    it 'expects zero opening balance' do
    expect(subject.balance).to eq 0
    end 
  end 

  describe '#top up' do 
    it {is_expected.to respond_to(:top_up).with(1).argument }
   
    it 'balance to update to 10 with top_up(10)' do 
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end 

    it 'has a max limit of 90'do 
      max_balance = Oystercard::LIMIT
      subject.top_up(max_balance)
      expect{subject.top_up(3)}.to raise_error "ERROR - card already holds max funds (Max = #{max_balance}"
    end 
  end 

let(:station) {double :station}
  describe '#touch_in' do 
    it 'raises error if insuff funds on card' do 
      expect{subject.touch_in(station)}.to raise_error "Insufficient Funds" 
    end 
  end 

  describe '#touch_out' do 
    it 'accepts 1 argument' do 
      expect(subject).to respond_to(:touch_out).with(1).argument
    end 
    it 'deducts min_fare from @balance' do 
      min_fare = Journey::MIN_FARE
      subject.top_up(10)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{subject.balance}.by(-min_fare)
    end 
  end 

end 

