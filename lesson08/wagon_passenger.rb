require_relative 'wagon'

class WagonPassenger < Wagon

  attr_reader :seats, :seats_occupied

  def initialize(seats)
    @seats = seats.to_i
    @seats_occupied = 0
    validate!
    super(:passenger)
  end

  def take_seat
    if seats_free.zero?
      raise RuntimeError, 'Свободных мест нет'
    end

    @seats_occupied += 1
  end

  def seats_free
    @seats - @seats_occupied
  end

  protected

  def validate!
    unless @seats > 0
      raise ArgumentError, 'Количество мест в вагоне не может быть меньше 1'
    end
  end
end
