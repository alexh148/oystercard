# frozen_string_literal: true

require 'oystercard'
require 'station'

describe 'user_stories' do
  let(:newcard) { Oystercard.new }
  let(:station) { Station.new }
  before(:each) do
    newcard.top_up(5)
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  it 'should return the new balance after topping up' do
    expect(newcard.balance).to eq(5)
  end

  # In order to protect my money
  # As a customer
  # I don't want to put too much money on my card

  it 'should not allow the customer to top up over Maximum balance' do
    msg = "Max balance £#{Oystercard::MAX_BALANCE} will be exceeded"
    newcard.top_up(82)
    expect { newcard.top_up(5) }.to raise_error msg
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  #
  # In order to get through the barriers
  # As a customer
  # I need to touch in and out

  it "should update a card as 'in use' when touching in" do
    newcard.touch_in('Waterloo')
    expect(newcard.in_journey?).to eq true
  end

  it "should update a card as 'not in use' when touching in" do
    newcard.touch_in('Waterloo')
    newcard.touch_out('waterloo')
    expect(newcard.in_journey?).to eq false
  end

  #
  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount for a single journey

  it 'should raise an error if touching in without the minimum balance' do
    msg = 'Cannot touch in: Not enough funds'
    newcard2 = Oystercard.new
    expect { newcard2.touch_in('Waterloo') }.to raise_error msg
  end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card

  it 'should deduct the minimum fare when completing journey' do
    newcard.touch_in('Waterloo')
    expect { newcard.touch_out('waterloo') }.to change { newcard.balance }.by(-1)
  end

  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from

  it 'should tell me which station i have travelled from' do
    newcard.touch_in('Waterloo')
    expect(newcard.journey.current[:entry]).to eq(:waterloo)
  end

  # In order to know where I have been
  # As a customer
  # I want to see all my previous trips

  it 'should return all of the previous trips' do
    newcard.touch_in('Waterloo')
    newcard.touch_out('waterloo')
    expect(newcard.journeylog.history).to include ({:entry => :waterloo, :exit => :waterloo})
  end

  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in

  it 'should know what zone a station is in' do
    expect(station.get_zone(:old_street)).to eq 2
  end

  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out

  it 'should deduct a penalty charge if touch in without touching out' do
    newcard.top_up(15)
    newcard.touch_in('Waterloo')
    newcard.touch_in('Waterloo')
    expect(newcard.balance).to eq 14
  end

  it 'should deduct a penalty charge if touch out without touch in' do
    newcard.top_up(15)
    newcard.touch_out('Waterloo')
    expect(newcard.balance).to eq 14
  end

  # In order to be charged the correct amount
  # As a customer
  # I need to have the correct fare calculated

  describe 'should deduct the correct fare for the journey' do
    it 'should deduct £1 if journey starts and ends in the same zone' do
      newcard.touch_in("waterloo")
      newcard.touch_out("waterloo")
      expect(newcard.balance).to eq 4
    end
    it 'should calculate the correct far for journeys between zones' do
      newcard.touch_in("waterloo")
      newcard.touch_out("old street")
      expect(newcard.balance).to eq 3
    end
  end
end
