# frozen_string_literal: true

# This is the Oystercard class
class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @in_use = false
    @balance = 0
    @fare = 1
  end

  def top_up(value)
    raise "Max balance £#{MAX_BALANCE} will be exceeded" if max_reached?(value)

    @balance += value
  end

  def touch_in
    raise 'Cannot touch in: Not enough funds' if balance < MIN_BALANCE
    @in_use = true
  end

  def touch_out
    deduct
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def max_reached?(value)
    @balance + value > MAX_BALANCE
  end

  def deduct
    @balance -= @fare
  end

end
