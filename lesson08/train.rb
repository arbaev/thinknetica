require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include InstanceCounter
  include Manufacturer
  include Validation

  TRAIN_NUMBER_FORMAT = /^[a-z\d]{3}(\-[a-z\d]{2})?$/i.freeze
  TRAIN_TYPES = %i[cargo passenger].freeze

  attr_reader :number, :speed, :type, :wags, :route

  @@trains_all = []
  def self.find(number)
    @@trains_all.find { |x| return x if x.number == number }
  end

  def initialize(number, type = :cargo)
    @number = number.to_s
    @type = type
    validate!
    @wags = []
    @speed = 0
    @route = nil
    @station_index = nil
    @@trains_all.push(self)
    register_instance
  end

  def route_set(r)
    @route = r
    @station_index = 0
    current_station.arrive(self)
  end

  def current_station
    return unless @route

    @route.route[@station_index]
  end

  def next_station
    return unless @route

    @route.route[@station_index + 1]
  end

  def prev_station
    return unless @route
    return if @station_index < 1

    @route.route[@station_index - 1]
  end

  def move_forward
    return unless @route && next_station

    current_station.depart(self)
    @station_index += 1
    current_station.arrive(self)
  end

  def move_back
    return unless @route && prev_station

    current_station.depart(self)
    @station_index -= 1
    current_station.arrive(self)
  end

  def wagon_add(wagon)
    return if moving?

    self.wags.push(wagon)
  end

  def wagon_del
    return if moving?

    self.wags.delete_at(-1)
  end

  def wagons
    wags.size
  end

  def each_wagon
    @wags.each { |w| yield(w) }
  end

  def moving?
    self.speed != 0
  end

  def speed_up
    @speed > 120 ? 120 : @speed += 20
  end

  def speed_down
    @speed <= 0 ? 0 : @speed -= 20
  end

  def stop
    @speed = 0
  end

  protected

  def validate!
    unless TRAIN_TYPES.include?(@type)
      raise ArgumentError, 'Неправильный тип поезда'
    end

    unless @number =~ TRAIN_NUMBER_FORMAT
      raise ArgumentError, 'Неправильный номер вагона: XXX(-XX)'
    end

    if self.class.find(@number)
      raise ArgumentError, 'Поезд с таким номером уже существует'
    end
  end
end
