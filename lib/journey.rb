class Journey

  attr_reader :current_journey, :history
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @current_journey = {entry: nil, exit: nil}
    @history = []
  end

  def start(station)
    @current_journey[:entry] = station
  end

  def end(station)
    @current_journey[:exit] = station
    @history << @current_journey
  end

  def fare
    return MINIMUM_FARE if complete?
    PENALTY_FARE
  end

  def reset
    @current_journey = {entry: nil, exit: nil}
  end

  def complete?
    @current_journey[:entry] != nil && @current_journey[:exit] != nil
  end

end
