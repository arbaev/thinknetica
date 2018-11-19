class Menus

  MAIN_MENU = {
    "1" => { label: "Создать: станцию, поезд, маршрут", func: :creating_menu },
    "2" => { label: "Редактировать: поезд, маршрут", func: :editing_menu },
    "3" => { label: "Информация и движение поезда", func: :moving_menu },
    "0" => { label: "Выход", func: :exit_menu }
  }
  CREATING_MENU = {
    "1" => { label: "Создать станцию", func: :station_create },
    "2" => { label: "Создать грузовой поезд", func: :train_create_cargo },
    "3" => { label: "Создать пассажирский поезд", func: :train_create_passenger },
    "4" => { label: "Создать маршрут", func: :route_create },
    "0" => { label: "Выход в главное меню", func: :exit_menu }
  }
  EDITING_MENU = {
    "1" => { label: "Добавить вагоны к поезду", func: :train_add_wagons },
    "2" => { label: "Отцепить вагоны от поезда", func: :train_del_wagons },
    "3" => { label: "Добавить станцию в маршрут", func: :route_add_station },
    "4" => { label: "Удалить станцию из маршрута", func: :route_del_station },
    "5" => { label: "Назначить маршрут поезду", func: :train_set_route },
    "0" => { label: "Выход в главное меню", func: :exit_menu }
  }
  MOVING_MENU = {
    "1" => { label: "Список станций", func: :station_list },
    "2" => { label: "Список маршрутов", func: :route_list },
    "3" => { label: "Список всех поездов", func: :train_list },
    "4" => { label: "Список всех поездов с маршрутом", func: :train_list_with_routes },
    "5" => { label: "Список поездов на станции", func: :station_trains_list },
    "6" => { label: "Движение по маршруту вперёд", func: :train_move_forward },
    "7" => { label: "Движение по маршруту назад", func: :train_move_back },
    "0" => { label: "Выход в главное меню", func: :exit_menu }
  }
  TOO_LONG = 99999999

  def initialize
    @stations = []
    @trains = []
    @routes = []

    main_menu
  end

  private

  def inputs(menu)
    puts '==================='
    menu.each {|k,v| puts "#{k} - #{v[:label]}" }
    puts '==================='
    command = gets.chomp.to_s

    menuitem = menu[command]
    if menuitem.nil?
      puts 'unknown command'
      return "unknown"
    end

    send(menuitem[:func])
  end

# MAIN_MENU options
  def main_menu
    !loop { inputs(MAIN_MENU) || break }
  end

  def creating_menu
    !loop { inputs(CREATING_MENU) || break }
  end

  def editing_menu
    !loop { inputs(EDITING_MENU) || break }
  end

  def moving_menu
    !loop { inputs(MOVING_MENU) || break }
  end

  def exit_menu
    return
  end

  def ask(question)
    print question + " "
    gets.chomp
  end

  def ask_i(question)
    print question + " "
    i = gets.chomp.to_i
    return TOO_LONG if i.zero?
    i-1 # because array index from zero but listings from one
  end

  def incorrect?(value)
    if value.nil?
      puts 'Неправильно указан номер'
      return true
    else
      false
    end
  end

  def station_list
    if @stations.empty?
      puts '=> Станций нет'
    else
      @stations.each.with_index(1) { |s, i| puts "#{i}. Станция #{s.name}, поездов #{s.trains.size}" }
    end
    @stations.size
  end

  def route_list
    if @routes.empty?
      puts '=> Маршрутов нет'
    else
      @routes.each.with_index(1) { |r, i| puts "#{i}. Маршрут #{route_info(r)}" }
    end
    @routes.size
  end

  def route_info(r)
    return "не задан" unless r
    points = []
    r.route.each { |r| points.push(r.name) }
    points.join('-')
  end

  def train_list
    if @trains.empty?
      puts "=> Поездов нет"
    else
      @trains.each.with_index(1) { |t, i| puts "#{i}. #{train_info(t)}, маршрут #{route_info(t.route)}" }
    end
    @trains.size
  end

  def train_list_with_routes
    trains_with_routs = @trains.select { |t| t.current_station }
    if trains_with_routs.empty?
      puts "=> Поездов с маршрутом нет"
    else
      trains_with_routs.each.with_index(1) { |t, i| puts "#{i}. #{train_info(t)}, маршрут #{route_info(t.route)}" }
    end
    trains_with_routs.size
  end

  def train_info(train)
    "поезд #{train.number}, тип: #{train.type}, вагонов: #{train.wagons}"
  end

  def station_create
    puts 'Создание станции'
    station = Station.new(ask('Введите название станции'))
    puts "=> Создана станция #{station.name}"
    @stations.push(station)
  end

  def route_create
    if station_list < 2
      puts "=> маршрут нельзя задать"
      return true
    end

    start_index = ask_i('Укажите номер начальной станции маршрута:')
    start = @stations[start_index]
    return 0 if incorrect?(start)
    finish_index = ask_i('Укажите номер конечной станции маршрута:')
    finish = @stations[finish_index]
    return 0 if incorrect?(finish)

    route = Route.new(start, finish)
    puts "Создан маршрут #{route_info(route)}"
    @routes.push(route)
  end

  def route_add_station
    return 0 if route_list.zero?
    route_index = ask_i('Выберите номер маршрута:')
    route = @routes[route_index]
    return 0 if incorrect?(route)

    station_list
    station_index = ask_i('Укажите номер станции для добавления в маршрут:')
    station = @stations[station_index]
    return 0 if incorrect?(station)

    route.add(station)
    puts "=> Станция добавлена, теперь маршрут: #{route_info(route)}"
    route
  end

  def route_del_station
    return 0 if route_list.zero?
    route_index = ask_i('Выберите номер маршрута:')
    route = @routes[route_index]
    return 0 if incorrect?(route)

    station_list
    station_index = ask_i('Укажите номер станции для удаления из маршрута:')
    station = @stations[station_index]
    return 0 if incorrect?(station)

    route.del(station)
    puts "=> Станция удалена, теперь маршрут: #{route_info(route)}"
    route
  end

  def station_trains_list
    return 0 if station_list.zero?
    station_index = ask_i('Введите номер станции, где показать поезда:')
    station = @stations[station_index]
    return 0 if incorrect?(station)

    if station.trains.empty?
      !puts "=> На станции #{station.name} поездов нет"
    else
      puts "=> На станции #{station.name} находятся поезда:"
      station.trains.each { |t| puts "Поезд #{t.number}, тип: #{t.type}, вагонов: #{t.wagons}" }
    end
  end

  def train_create_cargo
    train = TrainCargo.new(ask('Введите номер поезда'))
    @trains.push(train)
    !puts "=> Создан #{train_info(train)}"
  end

  def train_create_passenger
    train = TrainPassenger.new(ask('Введите номер поезда'))
    @trains.push(train)
    !puts "=> Создан #{train_info(train)}"
  end

  def train_add_wagons
    return 0 if train_list.zero?
    train_index = ask_i("Укажите индекс поезда для добавления вагонов:")
    train = @trains[train_index]
    return 0 if incorrect?(train)

    wagons_amount = ask("Сколько вагонов добавить?").to_i

    if train.type == :cargo
      wagons_amount.times { train.wagon_add(WagonCargo.new) }
    else
      wagons_amount.times { train.wagon_add(WagonPassenger.new) }
    end
    !puts "=> Вагоны добавлены, #{train_info(train)}"
  end

  def train_del_wagons
    return 0 if train_list.zero?
    train_index = ask_i("Укажите индекс поезда для удаления вагонов:")
    train = @trains[train_index]
    return 0 if incorrect?(train)

    wagons_amount = ask("Сколько вагонов отцепить?").to_i
    wagons_amount.times { train.wagon_del }
    !puts "=> Вагоны отцеплены, #{train_info(train)}"
  end

  def train_set_route
    return 0 if route_list.zero?
    route_index = ask_i('Выберите номер маршрута:')
    route = @routes[route_index]
    return 0 if incorrect?(route)

    return 0 if train_list.zero?
    train_index = ask_i("Укажите индекс поезда для назначения маршрута:")
    train = @trains[train_index]
    return 0 if incorrect?(train)

    train.route_set(route)
    !puts "=> Поезду #{train.number} установлен маршрут #{route_info(route)}"
  end

  def train_move_forward
    return 0 if train_list_with_routes.zero?
    train_index = ask_i("Укажите индекс поезда для движения вперёд")
    train = @trains[train_index]
    return 0 if incorrect?(train)
    return 0 if incorrect?(train.current_station)

    if train.move_forward
      puts "=> Поезд #{train.number} уехал со станции #{train.prev_station.name} и приехал на станцию #{train.current_station.name}."
    else
      puts "=> Поезд #{train.number} на конечной станции."
    end
    train.current_station
  end

  def train_move_back
    return 0 if train_list_with_routes.zero?
    train_index = ask_i("Укажите индекс поезда для движения назад")
    train = @trains[train_index]
    return 0 if incorrect?(train)
    return 0 if incorrect?(train.current_station)

    if train.move_back
      puts "=> Поезд #{train.number} приехал на станцию #{train.current_station.name}."
    else
      puts "=> Поезд #{train.number} на начальной станции."
    end
    train.current_station
  end

end
