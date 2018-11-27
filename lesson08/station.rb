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

  def each_train
    @trains.each { |t| yield(t) }
  end

  protected

  def validate!
    raise ArgumentError, 'Название станции не указано' if @name.nil?
    raise ArgumentError, 'Название станции не может быть пустым' if @name.empty?

    if @name[0] == ' '
      raise ArgumentError, 'Название станции не может начинаться с пробела'
    end

    if self.class.find(@name)
      raise ArgumentError, 'Станция с таким названием уже существует'
    end
  end
end
