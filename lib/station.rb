# frozen_string_literal: true

# This is a Station class
class Station

  def initialize
    @stations = { waterloo: 1,
             old_street: 2,
             liverpool_street: 3,
             holland_park: 4,
             holborn: 1 }
  end

  def get_zone(station)
    all[station]
  end

  private

  def all
    @stations
  end
end
