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
  attr_accessor :route
  attr_reader :speed, :wagons, :type, :number, :current

# Для создания поезда нужно указать его номер, опционально - тип и количество вагонов
  def initialize(number, type = :freight, wagons = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    puts "Создан поезд №#{self.number} типа #{self.type} длиной #{self.wagons} вагонов."
    return self
  end

# Сообщает тип поезда и другую информацию
  def info
    puts "Поезд №#{self.number} типа #{self.type}, вагонов: #{self.wagons}"
    return self
  end

# Останавливает поезд
  def stop
    if moving?
      puts "Поезд остановлен."
      self.speed = 0
    else
      puts "Поезд уже стоит."
    end
    return self
  end

# Увеличивает скорость поезда на 20 км/ч, макс.скорость 150 км/ч
  def faster
    self.speed += 20

    if moving? && self.speed >= 150
      self.speed = 150
      puts "Поезд №#{self.number} на максимальной скорости: #{self.speed}"
    else
      puts "Поезд №#{self.number} ускорился до #{self.speed} км/ч"
    end

    return self
  end

# Уменьшает скорость поезда на 20 км/ч
  def slower
    self.speed -= 20

    if moving?
      puts "Поезд №#{self.number} замедлился до #{self.speed} км/ч"
    else
      puts "Поезд №#{self.number} остановлен"
    end
    return self
  end

# Проверка, двигается ли поезд
  def moving?
    return self.speed > 0
  end

# Добавление одного вагона к поезду
  def add_wagon
    if moving?
      puts "Нельзя прицеплять вагон во время движения";
    else
      @wagons += 1
      puts "Поезду добавлен вагон. Теперь вагонов: #{self.wagons} шт."
    end
    return self
  end

# Удаление одного вагона от поезда
  def del_wagon
    if moving?
      puts "Нельзя отцеплять вагон во время движения";
    elsif self.wagons == 0
      puts "Нечего отцеплять, у поезда нет вагонов."
    else
      @wagons -= 1
      puts "От поезда отцеплен вагон. Теперь вагонов: #{self.wagons} шт."
    end
    return self
  end

# Задание маршрута
  def route_set(r)
    self.route = r.route
    @current = @start = @prev = route.first
    @fin = route.last
    puts "Поезду #{self.number} установлен маршрут #{@start}-#{@fin}. Следующая станция #{@current}"
    return self
  end

  def route_info
    final = ""
    if @current == @prev
      @prev = "отсутствует"
    end
    if @current == @fin
      final = ", конечная"
    end
    puts "Поезд двигается по маршруту #{@start}-#{@fin}. Предыдущая станция #{@prev}. Следующая станция #{@current}#{final}."
    return self.route
  end

# Перемещение поезда к следующей станции
  def move_forward
    if @current == @fin
      puts "Поезд уже на конечной станции: #{@current}"
    else
      next_index = self.route.index(@current) + 1
      @prev = @current
      @current = self.route[next_index]
      puts "Уехали со станции #{@prev}, приехали на станцию #{@current}"
    end
    return @current
  end

# Перемещение поезда к предыдущей станции
  def move_back
    if @current == @start
      puts "Поезд уже на начальной станции: #{@current}"
    else
      next_index = self.route.index(@current) - 1
      @prev = @current
      @current = self.route[next_index]
      puts "Уехали со станции #{@prev}, приехали на станцию #{@current}"
    end
    return @current
  end

end
