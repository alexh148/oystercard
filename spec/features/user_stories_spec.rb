# frozen_string_literal: true

describe 'user_stories' do
  # In order to use public transport
  # As a customer
  # I want money on my card

  it 'should have money on the oystercard' do
    newcard = Oystercard.new
    expect(newcard.balance).to eq(0)
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  it 'should return the new balance after topping up' do
    newcard = Oystercard.new
    newcard.top_up(5)
    expect(newcard.balance).to eq(5)
  end

  # In order to protect my money
  # As a customer
  # I don't want to put too much money on my card

  it 'should not allow the customer to top up over Maximum balance' do
    msg = "Max balance £#{Oystercard::MAX_BALANCE} will be exceeded"
    newcard = Oystercard.new
    newcard.top_up(87)
    expect { newcard.top_up(5) }.to raise_error msg
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card

  it 'should deduct a value from the card' do
    newcard = Oystercard.new
    newcard.top_up(5)
    newcard.deduct(2)
    expect(newcard.balance).to eq(3)
  end

  #
  # In order to get through the barriers
  # As a customer
  # I need to touch in and out

  it "should update a card as 'in use' when touching in" do
    newcard = Oystercard.new
    newcard.top_up(5)
    newcard.touch_in
    expect(newcard.in_journey?).to eq true
  end

  it "should update a card as 'not in use' when touching in" do
    newcard = Oystercard.new
    newcard.top_up(5)
    newcard.touch_in
    newcard.touch_out
    expect(newcard.in_journey?).to eq false
  end

  #
  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount for a single journey

  it 'should raise an error if we try to touch in without the minimum balance' do
    newcard = Oystercard.new
    expect { newcard.touch_in }.to raise_error 'Cannot touch in: Not enough funds'
  end

  # In order to pay for my journey
  # As a customer
  # I need to pay for my journey when it's complete
  #
  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from
  #
  # In order to know where I have been
  # As a customer
  # I want to see to all my previous trips
  #
  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in
  #
  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out
  #
  # In order to be charged the correct amount
  # As a customer
  # I need to have the correct fare calculated
end
