require 'station'

describe Station do
  describe '#defaults' do
    let (:station) {Station.new('Waterloo', 'Zone 1')}

    it 'should have a name' do
      expect(station).to respond_to(:name)
    end

    it 'should have a zone' do
      expect(station).to respond_to(:zone)
    end
  end
end
