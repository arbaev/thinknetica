# Класс Station (Станция):
#   Имеет название, которое указывается при ее создании
#   Может принимать поезда (по одному за раз)
#   Может возвращать список всех поездов на станции, находящиеся в текущий момент
#   Может возвращать список поездов на станции по типу: кол-во грузовых, пассажирских
#   Может отправлять поезда (по одному за раз, при этом, поезд удаляется
#     из списка поездов, находящихся на станции).
require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @@all_stations = []

  def self.all
    @@all_stations
  end
  def self.find(name)
    @@all_stations.find { |x| return x if x.name == name }
  end

  def initialize(name)
    @name = name.to_s
    validate!
    @trains = []
    @@all_stations.push(self)
    register_instance
  end

  def types
    types = {}
    self.trains.map { |t| types[t.type].nil? ? types[t.type] = 1 : types[t.type] += 1 }
    types
  end

  def arrive(train)
    self.trains.push(train)
  end

  def depart(train)
    self.trains.delete(train)
  end

  protected

  def validate!
    raise ArgumentError, 'Название станции не указано' if @name.nil?
    raise ArgumentError, 'Название станции не может быть пустым' if @name.empty?
    raise ArgumentError, 'Название станции не может начинаться с пробела' if @name[0] == ' '
    raise ArgumentError, 'Станция с таким названием уже существует' \
      if self.class.find(@name)
  end
end
