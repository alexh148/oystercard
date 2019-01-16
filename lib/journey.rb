class Journey

  attr_reader :current
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @current = {entry: nil, exit: nil}
  end

  def start(station)
    @current[:entry] = station
  end

  def end(station)
    @current[:exit] = station
  end

  def fare
    return MINIMUM_FARE if complete?
    PENALTY_FARE
  end

  def complete?
    @current[:entry] != nil && @current[:exit] != nil
  end

end
