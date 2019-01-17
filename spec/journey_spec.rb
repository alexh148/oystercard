require 'journey'

describe Journey do
  describe 'defaults' do
    it 'should store an empty current journey upon creation' do
      expect(subject.current).to eq({entry: nil, exit: nil})
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
      expect(subject.current[:entry]).to eq 'station'
    end
  end

  describe '#end' do
    it 'should set the exit station in current journey' do
      subject.end('station')
      expect(subject.current[:exit]).to eq 'station'
    end
  end

  describe '#fare' do
    it 'should return penalty fare by default' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'should return the correct fare if the journey is completed' do
      subject.start(:waterloo)
      subject.end(:old_street)
      expect(subject.fare).to eq 2
    end

    it 'should charge £1 if the journey starts and ends in the same zone' do
      subject.start(:waterloo)
      subject.end(:waterloo)
      expect(subject.fare).to eq 1
    end

  end
end
