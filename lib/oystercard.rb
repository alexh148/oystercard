# frozen_string_literal: true

# This is the Oystercard class

require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)

    @balance += value
  end

  def touch_in(station)
    raise 'Cannot touch in: Not enough funds' if balance < MIN_BALANCE
    deduct if in_journey?
    @journey.start(station)
  end

  def touch_out(station)
    @journey.end(station)
    deduct
    @journey.reset
  end

  def in_journey?
    @journey.current_journey[:entry] != nil
  end

  private

  def max_reached?(value)
    @balance + value > MAX_BALANCE
  end

  def deduct
    @balance -= @journey.fare
  end
end
