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
    @start = Station.new(start)
    @finish = Station.new(finish)
    @route = [@start, @finish]
    puts "Маршрут #{@start.name} - #{@finish.name} создан."
    return self
  end

# Выводит нумерованый список всех станций маршрута
  def list
    puts "Маршрут от #{self.start.name} до #{self.finish.name}"
    self.route.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
  end

# Добавляет новую станцию в маршрут после указанной имеющейся
  def add_after(after, name)
    s_index = self.station_index(after)

    if s_index.nil?
      puts "Станции #{after} нет в маршруте. Нельзя добавить новую после неё."
      return false
    end
    if after == self.finish.name
      puts "Нельзя добавить станцию после конечной станции."
      return false
    end

    puts "Станция #{name} добавлена после #{after}"
    self.route.insert(s_index + 1, Station.new(name))
  end

# Удаляет станцию из маршрута
  def delete(name)
    s_index = self.station_index(name)

    if s_index.nil?
      puts "Станции '#{name}' нет в маршруте, нельзя удалить."
      return false
    end
    if s_index == 0 || s_index == self.route.size - 1
      puts "Нельзя удалить начальную или конечную станции маршрута."
      return false
    end

    puts "Станция #{name} удалена из маршрута"
    self.route.delete_at(s_index)
    self.route
  end

  # возвращает индекс станции в маршруте или nil если не таковой не существует  
  def station_index(name)
    self.route.each_with_index { |station, index| return index if name == station.name }
    return nil
  end

end
