# console menu command methods for class Train
module MenusTrains
  private

  def train_create(type)
    number = ask('Введите номер поезда')
    train = type == :passenger ? TrainPassenger.new(number) : TrainCargo.new(number)
    puts "=> Создан #{train_info(train)}"
    @trains.push(train)
  rescue ArgumentError => e
    puts e.message
    retry
  end

  # show trains with selected attributes
  # input is an array [:attribute, :value] or just :attribute if value don't interesting
  # default attr :number means 'all trains' because they all have number attr
  def show_trains(attr = :number)
    trains_arr = trains_select(attr)
    raise ArgumentError, '=> Поездов нет' if trains_arr.empty?

    trains_arr.each.with_index(1) do |t, i|
      puts "#{i}. #{train_info(t)}, маршрут #{route_info(t.route)}"
    end
  rescue ArgumentError => e
    puts e.message
  end

  def trains_select(attr)
    if attr.is_a?(Array)
      @trains.select { |t| t.public_send(attr.first) == attr.last }
    else
      @trains.select(&attr)
    end
  end

  def train_info(train)
    "поезд #{train.number}, тип: #{train.type}, вагонов: #{train.wagons}"
  end

  def train_add_wagons
    return if show_trains.nil?

    train = get_selected_from(@trains)
    wagons_amount = ask('Сколько вагонов добавить?').to_i

    if train.type == :cargo
      capacity = ask('Какой объём каждого вагона?').to_f
      wagons_amount.times { train.wagon_add(WagonCargo.new(capacity)) }
    else
      seats = ask('Какое количество мест у каждого вагона?').to_i
      wagons_amount.times { train.wagon_add(WagonPassenger.new(seats)) }
    end
    puts "=> Вагоны добавлены, #{train_info(train)}"
  rescue ArgumentError => e
    puts e.message
  end

  def train_del_wagons
    return if show_trains.nil?

    train = get_selected_from(@trains)
    wagons_amount = ask('Сколько вагонов отцепить?').to_i
    wagons_amount.times { train.wagon_del }
    puts "=> Вагоны отцеплены, #{train_info(train)}"
  rescue ArgumentError => e
    puts e.message
  end

  def train_set_route
    return if show_routes.nil?
    route = get_selected_from(@routes)

    return if show_trains.nil?
    train = get_selected_from(@trains)

    train.route_set(route)
    puts "=> Поезду #{train.number} установлен маршрут #{route_info(route)}"
  rescue ArgumentError => e
    puts e.message
  end

  def train_move_forward
    train = train_moving
    return if train.nil?

    if train.move_forward
      puts "=> Поезд #{train.number} уехал со станции \
#{train.prev_station.name} и приехал на станцию #{train.current_station.name}."
    else
      puts "=> Поезд #{train.number} на конечной станции."
    end
    train.current_station
  rescue ArgumentError => e
    puts e.message
  end

  def train_move_back
    train = train_moving
    return if train.nil?

    if train.move_back
      puts "=> Поезд #{train.number} приехал на станцию #{train.current_station.name}."
    else
      puts "=> Поезд #{train.number} на начальной станции."
    end
    train.current_station
  rescue ArgumentError => e
    puts e.message
  end

  def train_moving
    trains_with_routes = show_trains_with_routes
    get_selected_from(trains_with_routes)
  rescue ArgumentError => e
    puts e.message
  end
end
