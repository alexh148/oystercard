require 'journey'

describe Journey do
  describe 'defaults' do
    it 'should store an empty current journey upon creation' do
      expect(subject.current_journey).to eq({entry: nil, exit: nil})
    end
  end

  # describe '#journeys' do
  #
  #   it 'should return a journey array with a journey' do
  #     subject.top_up(5)
  #     subject.touch_in(entry_station)
  #     subject.touch_out(exit_station)
  #     expect(subject.journey.history).to include journey
  #   end
  # end

  describe '#start' do
    it 'should set the entry station in current journey' do
      subject.start('station')
      expect(subject.current_journey[:entry]).to eq 'station'
    end
  end

  describe '#end' do
    it 'should set the exit station in current journey' do
      subject.end('station')
      expect(subject.current_journey[:exit]).to eq 'station'
    end
  end

  describe '#fare' do
    it 'should return penalty fare by default' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'should return the minimum fare if there is an entry and exit station' do
      subject.start('station')
      subject.end('station')
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
  end
end
