# frozen_string_literal: true

# This is the Oystercard class

require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  attr_reader :balance, :journey, :journeylog
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
    @journeylog = JourneyLog.new
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)

    @balance += value
  end

  def touch_in(station)
    raise 'Cannot touch in: Not enough funds' if balance < MIN_BALANCE
    # p in_journey?
    deduct if in_journey?
    # p 'Ive just deducted' if in_journey?
    # p @journey.current
    @journeylog.store(@journey.current.clone) if in_journey?
    # p @journey.current
    # p 'Ive just stored' if in_journey?
    # p @journey.current
    @journey.start(station)
    # p @journey.current
  end

  def touch_out(station)
    @journey.end(station)
    deduct
    @journeylog.store(@journey.current)
    @journey = Journey.new
  end

  def in_journey?
    @journey.current[:entry] != nil
  end

  def unsuccessful_journey
    deduct
  end

  private

  def max_reached?(value)
    @balance + value > MAX_BALANCE
  end

  def deduct
    @balance -= @journey.fare
  end
end
