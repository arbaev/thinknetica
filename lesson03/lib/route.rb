# Класс Route (Маршрут):
#  Имеет начальную и конечную станцию, а также список промежуточных станций.
#    Начальная и конечная станции указываются при создании маршрута, 
#    а промежуточные могут добавляться между ними.
#  Может добавлять промежуточную станцию в список
#  Может удалять промежуточную станцию из списка
#  Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :route

# Для создания маршрута нужно указать массив станций. 
# Минимально 2 станции, начало и конец маршрута
  def initialize(route = [])
    if route.size < 2
      puts "В маршруте не хватает станций"
    else
      @route = route
      puts "Маршрут #{@route.first} - #{@route.last} создан."
      return self
    end
  end

# Выводит нумерованый список всех станций маршрута
  def list
    puts "Маршрут от #{self.route.first} до #{self.route.last}"
    self.route.each_with_index { |station, index| puts "#{index+1}. #{station}" }
  end

# Вставляет станцию в маршрут по указанному порядковому номеру (от 1 и далее)
# Метод не проверяет правильность индекса, тем и плох. Лучше использовать метод add_after
  def add_at(index, name)
    self.route.insert(index-1, name)
    puts "Станция #{name} добавлена между #{self.route[index-2]} и #{self.route[index]}"
    return self
  end

# Вставляет новую станцию в маршрут после указанной имеющейся
  def add_after(after, name)
    after_index = self.route.index(after)
    if after_index.nil?
      puts "Станции #{after} нет в маршруте. Нельзя добавить новую после неё."
      return false
    end
    self.route.insert(after_index+1, name)
    puts "Станция #{name} добавлена после #{after}"
    return self
  end

# Удаляет станцию из маршрута
  def delete(name)
    if self.route.size <= 2
      puts "Маршрут не имеет промежуточных станций, нечего удалять"
      return false
    end

    if self.route.include?(name)
      self.route.delete(name)
      puts "Станция '#{name}' удалена из маршрута"
    else
      puts "Станции '#{name}' нет в маршруте, нельзя удалить."
    end
    return self
  end

end
