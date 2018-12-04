require_relative 'instance_counter'
require_relative 'validation'
# methods for Stations
class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains
  validate :name, :presence
  validate :name, :class, String
  validate :name, :format, /^[a-z]{3}$/

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
    validate_self
    @trains = []
    @@all_stations.push(self)
    register_instance
  end

  def types
    types = {}
    @trains.map { |t| types[t.type].nil? ? types[t.type] = 1 : types[t.type] += 1 }
    types
  end

  def arrive(train)
    @trains.push(train)
  end

  def depart(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each { |t| yield(t) }
  end

  protected

  def validate_self
    if self.class.find(@name)
      raise ArgumentError, '=> Станция с таким названием уже существует'
    end
  end
end
