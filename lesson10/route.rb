require_relative 'instance_counter'
require_relative 'validation'
# methods for Routes
class Route
  include InstanceCounter
  include Validation

  attr_reader :start, :finish
  validate :start, :class, Station
  validate :finish, :class, Station
  validate :start, :equal, :finish

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

    if [@start, @finish].include?(station)
      raise ArgumentError, '=> Нельзя удалить начальную или конечную станции'
    end

    @stations.delete(station)
  end
end
