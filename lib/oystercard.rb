# frozen_string_literal: true

# This is the Oystercard class

require_relative 'journey'
require_relative 'journey_log'


class Oystercard
  attr_reader :balance, :journey, :journeylog
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(journey = Journey.new, journeylog = JourneyLog.new)
    @balance = 0
    @journey = journey
    @journeylog = journeylog
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)
    @balance += value
  end

  def touch_in(station)
    raise 'Cannot touch in: Not enough funds' if balance < MIN_BALANCE
    complete_journey if in_journey?
    @journey.start(convert_to_symbol(station))
  end

  def touch_out(station)
    @journey.end(convert_to_symbol(station))
    complete_journey
    @journey = Journey.new
  end

  def in_journey?
    @journey.current[:entry] != nil
  end

  private

  def max_reached?(value)
    @balance + value > MAX_BALANCE
  end

  def convert_to_symbol(string)
    string.split(' ').join('_').downcase.to_sym
  end

  def complete_journey
    @journeylog.store(@journey.current.clone)
    @balance -= @journey.fare
  end

end
