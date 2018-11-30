require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [@start, @finish]
    validate!
    register_instance
  end

  def route
    @stations
  end

  def length
    @stations.length
  end

  def add(station)
    if @stations.include?(station)
      raise ArgumentError, "=> Станция #{station.name} уже есть маршруте"
    end

    @stations.insert(-2, station)
  end

  def del(station)
    unless @stations.index(station)
      raise ArgumentError, "=> Станции #{station.name} нет в маршруте"
    end

    if station == @start || station == @finish
      raise ArgumentError, '=> Нельзя удалить начальную или конечную станции'
    end

    @stations.delete(station)
  end

  protected

  def validate!
    if @stations.find { |s| s.class != Station }
      raise ArgumentError, '=> Параметром маршрута должна быть станция'
    end

    if @start == @finish
      raise ArgumentError, '=> Начальная и конечная станции должны быть разные'
    end
  end
end
