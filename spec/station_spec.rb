require 'station'

describe Station do 
  describe '#initialization' do 
    let(:name) {"station name"}
    let(:zone) {1}
    let(:subject) {Station.new(name, zone)}

    it 'should have a name var on init' do 
      expect(subject.name).to eq "station name"
    end 

    it 'should have a zone var on init' do 
      expect(subject.zone).to eq 1
    end 
  end 
end 