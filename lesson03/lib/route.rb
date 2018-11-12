# Класс Route (Маршрут):
#  Имеет начальную и конечную станцию, а также список промежуточных станций.
#    Начальная и конечная станции указываются при создании маршрута, 
#    а промежуточные могут добавляться между ними.
#  Может добавлять промежуточную станцию в список
#  Может удалять промежуточную станцию из списка
#  Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :route, :start, :finish

# Для создания маршрута нужно указать начальную и конечную станцию. 
  def initialize(start, finish)
    @start = make_station_obj(start)
    @finish = make_station_obj(finish)
    @route = [@start, @finish]
    puts "Маршрут #{@start.name} - #{@finish.name} создан."
  end

# Выводит нумерованый список всех станций маршрута; возвращает массив станций в маршруте
  def list
    puts "Маршрут от #{self.start.name} до #{self.finish.name}"
    self.route.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
  end

# Добавляет новую станцию в маршрут после указанной имеющейся;
# возвращает массив станций в маршруте.
# В качестве новой станции принимает объект станции 
# или строку с названием новой станции — будет создан новый объект станции
# В качестве «станции после» можно указать объект станции или её название в виде строки
  def add_after(station_after, station_new)
    station_after = station_obj(station_after) if station_after.class == String
    station_new = make_station_obj(station_new)
    s_index = self.station_index(station_after)

    if s_index.nil?
      puts "Станции нет в маршруте. Нельзя добавить новую после неё."
      return
    end
    if station_after == self.finish
      puts "Нельзя добавить станцию после конечной станции."
      return
    end

    puts "Станция #{station_new.name} добавлена после #{station_after.name}"
    self.route.insert(s_index + 1, station_new)
  end

# Удаляет станцию из маршрута; возвращает массив станций в маршруте
# Станцию можно указать как объект или её название в виде строки
  def delete(station)
    station = make_station_obj(station)

    s_index = self.station_index(station)

    if s_index.nil? || station.nil?
      puts "Такой станции нет в маршруте, нельзя удалить."
      return
    end
    if s_index == 0 || s_index == self.route.size - 1
      puts "Нельзя удалить начальную или конечную станции маршрута."
      return
    end

    puts "Станция #{station.name} удалена из маршрута"
    self.route.delete_at(s_index)
    self.route
  end

# возвращает индекс станции в маршруте или nil если не таковой не существует
  def station_index(station)
    self.route.each_with_index { |s, index| return index if s == station }
    return
  end

# возвращает объект станции по его параметру name или nil если не таковой не существует
  def station_obj(name)
    self.route.each_with_index { |station, index| return station if name == station.name }
    return
  end

# если задана строка имени станции, то создаёт её, иначе возвращает объект станции,
  def make_station_obj(station)
    return Station.new(station) if station.class == String
    station
  end

end
