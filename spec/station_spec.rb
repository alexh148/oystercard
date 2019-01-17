# frozen_string_literal: true

require 'station'

describe Station do
  describe '#defaults' do
    # let(:station) { Station.new('Waterloo', 1) }
    #
    # it 'should return its name' do
    #   expect(station.name).to eq('Waterloo')
    # end
    #
    # it 'should return its zone' do
    #   expect(station.zone).to eq(1)
    # end

    it 'should get a station zone' do
      expect(subject.get_zone(:old_street)).to eq 2
    end
  end
end
