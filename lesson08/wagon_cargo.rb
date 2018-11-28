require_relative 'wagon'

class WagonCargo < Wagon

  attr_reader :capacity, :capacity_occupied

  def initialize(capacity)
    @capacity = capacity
    @capacity_occupied = 0.0
    validate!
    super(:cargo)
  end

  def take_capacity(how_much)
    how_much = how_much
    if capacity_free - how_much < 0
      raise ArgumentError, "Не хватает объёма, свободно #{capacity_free} м3"
    end

    @capacity_occupied += how_much
  end

  def capacity_free
    @capacity - @capacity_occupied
  end

  protected

  def validate!
    unless @capacity > 0
      raise ArgumentError, 'Объём вагона не может быть меньше 0'
    end
  end
end
