# Класс Train (Поезд):
#   Имеет номер (произвольная строка) и тип (грузовой, пассажирский)
#     и количество вагонов, эти данные указываются при создании экземпляра класса
#   Может набирать скорость
#   Может возвращать текущую скорость
#   Может тормозить (сбрасывать скорость до нуля)
#   Может возвращать количество вагонов
#   Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
#     метод просто увеличивает или уменьшает количество вагонов).
#     Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
#   Может принимать маршрут следования (объект класса Route).
#   При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
#   Может перемещаться между станциями, указанными в маршруте.
#      Перемещение возможно вперед и назад, но только на 1 станцию за раз.
#   Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  
  attr_reader :number, :speed, :type, :wags

  def initialize(number, type = :cargo)
    @number = number
    @type = type
    @wags = []
    @speed = 0
    @route = nil
    @station_index = nil
  end

  def route_set(r)
    @route = r
    @station_index = 0
    current_station.arrive(self)
  end

  def current_station
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

end
