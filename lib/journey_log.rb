class JourneyLog
  attr_reader :history

  def initialize
    @history = []
  end

  def store(journey)
    @history << journey
  end
end
