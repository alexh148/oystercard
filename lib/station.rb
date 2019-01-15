# frozen_string_literal: true

# This is a Station class
class Station
  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end
end
