# console menu command methods for class Train
module MenusTrains
  private

  def train_create(type)
    num = ask('Введите номер поезда')
    train = type == :passenger ? TrainPassenger.new(num) : TrainCargo.new(num)
    puts "=> Создан #{train_info(train)}"
    @trains.push(train)
  rescue ArgumentError => e
    puts e.message
    retry
  end

  # Show trains with selected attributes.
  # input is an array [:attribute, :value]
  # or just :attribute if value doesn't matter
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

  def choose_train(train_attr = :number)
    trains = show_trains(train_attr)
    return if trains.nil?

    get_selected_from(trains)
  rescue ArgumentError => e
    puts e.message
  end

  def train_set_route
    return if show_routes.nil?

    route = get_selected_from(@routes)
    train = choose_train
    return if train.nil?

    train.route_set(route)
    puts "=> Поезду #{train.number} установлен маршрут #{route_info(route)}"
  rescue ArgumentError => e
    puts e.message
  end

  def train_move_forward
    train = choose_train(:current_station)
    return if train.nil?

    if train.move_forward
      puts "=> Поезд #{train.number} уехал со станции "\
           "#{train.prev_station.name} и приехал "\
           "на станцию #{train.current_station.name}."
    else
      puts "=> Поезд #{train.number} на конечной станции."
    end
    train.current_station
  rescue ArgumentError => e
    puts e.message
  end

  def train_move_back
    train = choose_train(:current_station)
    return if train.nil?

    if train.move_back
      puts "=> Поезд #{train.number} приехал "\
           "на станцию #{train.current_station.name}."
    else
      puts "=> Поезд #{train.number} на начальной станции."
    end
    train.current_station
  rescue ArgumentError => e
    puts e.message
  end
end
