require 'journey_log'

describe JourneyLog do
  context 'when initialized' do
    it 'should have an empty history array' do
      expect(subject.history).to be_empty
    end
  end

  describe '#store' do
    let(:journey) { {entry: 'Station_1', exit: 'Station_2'} }
    it 'should push a journey into the history array' do
      subject.store(journey)
      expect(subject.history).to include(journey)
    end
  end
end
