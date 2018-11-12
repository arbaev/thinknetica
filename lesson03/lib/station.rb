# Класс Station (Станция):
#   Имеет название, которое указывается при ее создании
#   Может принимать поезда (по одному за раз)
#   Может возвращать список всех поездов на станции, находящиеся в текущий момент
#   Может возвращать список поездов на станции по типу: кол-во грузовых, пассажирских
#   Может отправлять поезда (по одному за раз, при этом, поезд удаляется
#     из списка поездов, находящихся на станции).

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    puts "Станция #{@name} создана"
  end

# Прибытие поезда на станцию. Принимает объект «поезд», возвращает объект «станция»
  def arrive(train)
    if train.current_station == self
      puts "Поезд №#{train.number} уже на станции #{self.name}"
    else
      train.current_station = self
      self.trains.push(train)
      puts "Поезд №#{train.number} и типом #{train.type} прибыл на станцию #{self.name}"
    end
    return self
  end

# Отправление поезда со станции. Переезд на следующую станцию.
# Принимает объект «поезд», возвращает объект «станция»
  def departure(train)
    if train.current_station == self
      self.trains.delete(train)
      puts "Поезд №#{train.number} выехал со станции #{self.name}"
      return self
    else
      return      
    end
  end

# выводит список поездов на станции; возвращает массив поездов на станции
  def list
    return unless has_trains?

    puts "На станции #{self.name} находятся поезда:"
    self.trains.map { |t| puts "№#{t.number} тип #{t.type} вагонов #{t.wagons}" }
    return self.trains
  end

# выводит список типов поездов на станции; возвращает хеш типов поездов
  def list_types
    return unless has_trains?

    types = {}
    self.trains.map { |t| types[t.type].nil? ? types[t.type] = 1 : types[t.type] += 1 }
    puts "На станции #{self.name} находятся поезда:"
    types.map { |typ, count| puts "типа #{typ}: #{count} шт." }
    types
  end

  def has_trains?
    if self.trains.empty?
      puts "На станции #{self.name} поездов нет."
      return
    else
      true
    end
  end

end
