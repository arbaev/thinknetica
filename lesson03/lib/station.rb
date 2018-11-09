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
    @trains = {}
    puts "Станция #{@name} создана"
    return self
  end

  def arrive(train)
    num = train.number
    type = train.type
    self.trains[num] = type
    puts "Поезд с номером #{num} и типом #{type} принят на станцию #{self.name}"
    return self.trains
  end

  def departure(train)
    self.trains.delete(train.number)
    puts "Поезд #{train.number} выехал со станции #{self.name}"
    return self.trains
  end

  def list
    if self.trains.empty?
      puts "На станции #{self.name} поездов нет."
    else
      puts "На станции #{self.name} находятся поезда:"
      self.trains.map{|n,t| puts "№#{n} тип #{t}"}
    end
    return self.trains
  end

  def list_by_type
    by_type = {}
    self.trains.map do |n,t|
      i = by_type[t] || 1
      i += 1
      by_type.store(t, i)
    end
    puts "На станции #{self.name} находятся поезда:"
    by_type.map { |n,t| puts "типа #{n} - #{t} шт." }
    return self.trains
  end

end
