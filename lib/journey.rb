require_relative 'station'

class Journey

  attr_reader :current
  PENALTY_FARE = 6

  def initialize
    @current = {entry: nil, exit: nil}
    @stations = Station.new
  end

  def start(station)
    @current[:entry] = station
  end

  def end(station)
    @current[:exit] = station
  end

  def fare
    return calculate_fare if complete?
    PENALTY_FARE
  end

  def complete?
    @current[:entry] != nil && @current[:exit] != nil
  end

  private

  def calculate_fare
    entry_zone = @stations.get_zone(@current[:entry])
    exit_zone = @stations.get_zone(@current[:exit])
    (entry_zone - exit_zone).abs + 1
  end

end
