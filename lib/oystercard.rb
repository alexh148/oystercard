# frozen_string_literal: true

# This is the Oystercard class
class Oystercard
  attr_reader :balance, :journeys, :entry_station, :exit_station
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)

    @balance += value
  end

  def touch_in(station)
    raise 'Cannot touch in: Not enough funds' if balance < MIN_BALANCE

    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
    @journeys << {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
    deduct
  end

  def in_journey?
    !!@entry_station
  end

  private

  def max_reached?(value)
    @balance + value > MAX_BALANCE
  end

  def deduct(value = MIN_CHARGE)
    @balance -= value
  end

end
