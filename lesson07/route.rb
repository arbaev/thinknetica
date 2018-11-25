# Класс Route (Маршрут):
#  Имеет начальную и конечную станцию, а также список промежуточных станций.
#    Начальная и конечная станции указываются при создании маршрута,
#    а промежуточные могут добавляться между ними.
#  Может добавлять промежуточную станцию в список
#  Может удалять промежуточную станцию из списка
#  Может выводить список всех станций по-порядку от начальной до конечной
require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :start, :finish, :points

  def initialize(start, finish)
    validate!(start)
    validate!(finish)
    @start = start
    @finish = finish
    @points = []
    register_instance
  end

  def route
    [@start, @points, @finish].flatten.compact
  end

  def add(station)
    validate!(station)
    self.points.push(station)
  end

  def del(station)
    validate!(station)
    self.points.delete(station)
  end

  def valid?
    route.each { |s| validate!(s) }
    true
  rescue ArgumentError
    false
  end

  protected

  def validate!(station)
    raise ArgumentError, 'Параметром маршрута должна быть станция' \
      unless station.class == Station
  end
end
