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
  attr_accessor :route, :current_station
  attr_reader :speed, :wagons, :type, :number, :current_station_index

# Для создания поезда нужно указать его номер, опционально - тип и количество вагонов
  def initialize(number, type = :freight, wagons = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = []
    @current_station = nil
    @current_station_index = nil # индекс текущей станции в маршруте
    puts "Создан поезд №#{self.number} типа #{self.type} длиной #{self.wagons} вагонов."
  end

# Сообщает тип поезда и другую информацию; возвращает объект «поезд»
  def info
    puts "Поезд №#{self.number} типа #{self.type}, вагонов: #{self.wagons}"
  end

# Останавливает поезд; возвращает текущую скорость (0)
  def stop
    if moving?
      puts "Поезд остановлен."
      self.speed = 0
    else
      puts "Поезд уже стоит."
    end
    return self.speed
  end

# Увеличивает скорость поезда на 20 км/ч, макс.скорость 150 км/ч; возвращает текущую скорость
  def speed_up
    self.speed += 20
    if moving? && self.speed >= 150
      self.speed = 150
      puts "Поезд №#{self.number} на максимальной скорости: #{self.speed}"
    else
      puts "Поезд №#{self.number} ускорился до #{self.speed} км/ч"
    end
    return self.speed
  end

# Уменьшает скорость поезда на 20 км/ч; возвращает текущую скорость
  def speed_down
    self.speed -= 20
    if moving?
      puts "Поезд №#{self.number} замедлился до #{self.speed} км/ч"
    else
      puts "Поезд №#{self.number} остановлен"
    end
    return self.speed
  end

# Проверка, двигается ли поезд
  def moving?
    return self.speed > 0
  end

# Добавление одного вагона к поезду; возвращает количество вагонов или nil если ошибка
  def add_wagon
    if moving?
      puts "Нельзя прицеплять вагон во время движения"
      return
    else
      @wagons += 1
      puts "Поезду добавлен вагон. Теперь вагонов: #{self.wagons} шт."
    end
    return self.wagons
  end

# Удаление одного вагона от поезда; возвращает количество вагонов или nil если ошибка
  def del_wagon
    if moving?
      puts "Нельзя отцеплять вагон во время движения";
      return
    elsif self.wagons == 0
      puts "Нечего отцеплять, у поезда нет вагонов."
      return
    else
      @wagons -= 1
      puts "От поезда отцеплен вагон. Теперь вагонов: #{self.wagons} шт."
    end
    return self.wagons
  end

# Установка маршрута
# Принимает объект маршрут; возвращает массив станций в маршруте
  def route_set(r)
    self.route = r.route
    puts "Поезду №#{self.number} установлен маршрут #{self.route.first.name}-#{self.route.last.name}."
    self.current_station_index = 0
    self.current_station = self.route[self.current_station_index].arrive(self)
    return self.route
  end

# Вывод информации о маршруте; возвращает массив станций в маршруте или nil
  def route_info
    return unless has_route?
    puts "Поезд двигается по маршруту #{self.route.first.name}-#{self.route.last.name}. \
Текущая станция #{self.current_station.name}. Предыдущая станция #{prev_station.name}. \
Следующая станция #{next_station.name}."
    return self.route
  end

# Перемещение поезда к следующей станции; возвращает станцию на которую прибыл или nil при ошибке
  def move_forward
    return unless has_route?

    if self.current_station == self.route.last
      puts "Поезд уже на конечной станции"
      return self.current_station
    end

    prev = self.current_station.departure(self)
    self.current_station_index += 1
    self.current_station = self.route[self.current_station_index].arrive(self)
    puts "Уехали со станции #{prev.name}, приехали на станцию #{self.current_station.name}"
    return self.current_station
  end

# Перемещение поезда к предыдущей станции; возвращает станцию на которую прибыл или nil при ошибке
  def move_back
    return unless has_route?

    if self.current_station == self.route.first
      puts "Поезд уже на начальной станции"
      return self.current_station
    end

    prev = self.current_station.departure(self)
    self.current_station_index -= 1
    self.current_station = self.route[self.current_station_index].arrive(self)
    puts "Уехали со станции #{prev.name}, приехали на станцию #{self.current_station.name}"
    return self.current_station
  end

# Возвращает следующую станцию маршрута
  def next_station
    return unless has_route?
    nex = self.current_station_index == self.route.size - 1 ? self.current_station_index : self.current_station_index + 1
    self.route[nex]
  end

# Возвращает предыдущую станцию маршрута
def prev_station
  return unless has_route?
  prev = self.current_station_index - 1 < 0 ? 0 : self.current_station_index - 1
  self.route[prev]
end

  def has_route?
    if self.route.empty?
      puts "Поезду не задан маршрут."
      return
    else
      true
    end
  end

  private

  attr_writer :speed, :current_station_index

end
