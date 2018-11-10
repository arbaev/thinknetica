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
    return self
  end

  def arrive(train)
    if train.current == self
      puts "Поезд #{train.number} уже на станции #{self.name}"
    else
      train.current = self
      self.trains.push(train)
      puts "Поезд с номером #{train.number} и типом #{train.type} принят на станцию #{self.name}"
    end
    return self
  end

# Отправление поезда со станции. Переезд на следующую станцию,
  def departure(train)
    if train.route.any?
      train.move_forward
    end
    puts "Поезд #{train.number} выехал со станции #{self.name}"
    return self.trains
  end

  def list
    if self.trains.empty?
      puts "На станции #{self.name} поездов нет."
    else
      puts "На станции #{self.name} находятся поезда:"
      self.trains.map { |t| puts "№#{t.number} тип #{t.type} вагонов #{t.wagons}" }
    end
    return self
  end

  def list_types
    if self.trains.empty?
      puts "На станции #{self.name} поездов нет."
    else
      types = {}
      self.trains.map { |t| types[t.type].nil? ? types[t.type] = 1 : types[t.type] += 1 }
      puts "На станции #{self.name} находят поезда:"
      types.map { |typ, count| puts "типа #{typ}: #{count} шт." }
    end
    return self.trains
  end

end
