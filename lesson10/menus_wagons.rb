# console menu command methods for class Wagon
module MenusWagons
  private

  def show_wagons(train)
    raise ArgumentError, 'У поезда нет вагонов' if train.wags.empty?

    i = 0
    train.each_wagon do |wag|
      i += 1
      puts "#{i}. #{wagon_info(wag)}"
    end
  rescue ArgumentError => e
    puts e.message
  end

  def wagon_info(wagon)
    if wagon.type == :cargo
      "тип: #{wagon.type}, свободно #{wagon.capacity_free} м3, "\
      "занято #{wagon.capacity_occupied} м3"
    else
      "тип: #{wagon.type}, свободно #{wagon.seats_free} мест, "\
      "занято #{wagon.seats_occupied} мест"
    end
  end

  def wagons_list
    train = choose_train
    return if train.nil?

    show_wagons(train)
  end

  def load_wagon_cargo
    train = choose_train(%i[type cargo])
    return if train.nil?

    wagon = choose_wagon(train)
    return if wagon.nil?

    load = ask('Сколько кубометров желаете занять? ').to_f
    wagon.take_capacity(load)
    puts wagon_info(wagon)
  rescue ArgumentError => e
    puts e.message
  end

  def load_wagon_passenger
    train = choose_train(%i[type passenger])
    return if train.nil?

    wagon = choose_wagon(train)
    return if wagon.nil?

    load = ask('Сколько мест желаете занять? ').to_i
    load.times { wagon.take_seat }
    puts wagon_info(wagon)
  rescue ArgumentError => e
    puts e.message
  end

  def choose_wagon(train)
    wagons = show_wagons(train)
    return if wagons.nil?

    get_selected_from(wagons)
  end

  def train_add_wagons
    train = choose_train
    return if train.nil?

    amount = ask('Сколько вагонов добавить?').to_i
    add_wagons_by_type(train, amount)

    puts "=> Вагоны добавлены, #{train_info(train)}"
  rescue ArgumentError => e
    puts e.message
  end

  def add_wagons_by_type(train, amount)
    if train.type == :cargo
      capacity = ask('Какой объём каждого вагона?').to_f
      amount.times { train.wagon_add(WagonCargo.new(capacity)) }
    else
      seats = ask('Какое количество мест у каждого вагона?').to_i
      amount.times { train.wagon_add(WagonPassenger.new(seats)) }
    end
  end

  def train_del_wagons
    train = choose_train
    return if train.nil?

    wagon = choose_wagon(train)
    return if wagon.nil?

    train.wagon_del(wagon)
    puts "=> Вагон отцеплен, #{train_info(train)}"
  rescue ArgumentError => e
    puts e.message
  end
end
