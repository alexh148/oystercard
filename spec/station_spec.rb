# frozen_string_literal: true

require 'station'

describe Station do
  describe '#defaults' do
    let(:station) { Station.new('Waterloo', 1) }

    it 'should return its name' do
      expect(station.name).to eq('Waterloo')
    end

    it 'should return its zone' do
      expect(station.zone).to eq(1)
    end
  end
end
