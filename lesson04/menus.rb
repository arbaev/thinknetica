class Menus

  MAIN_MENU = {
    "1" => { label: "Действия со станцией", func: :station_menu },
    "2" => { label: "Действия с маршрутом", func: :route_menu },
    "3" => { label: "Действия с поездом", func: :train_menu },
    "0" => { label: "Выход", func: :exit_menu }
  }
  STATION_MENU = {
    "1" => { label: "Создать станцию", func: :station_create },
    "2" => { label: "Список станций", func: :station_list },
    "3" => { label: "Список маршрутов", func: :route_list },
    "4" => { label: "Список поездов на станции", func: :station_trains_list },
    "0" => { label: "Выход в главное меню", func: :exit_menu }
  }
  TRAIN_MENU = {
    "1" => { label: "Создать грузовой поезд", func: :train_create_cargo },
    "2" => { label: "Создать пассажирский поезд", func: :train_create_passenger },
    "3" => { label: "Добавить вагоны к поезду", func: :train_add_wagons },
    "4" => { label: "Отцепить вагоны от поезда", func: :train_del_wagons },
    "5" => { label: "Назначить маршрут поезду", func: :train_set_route },
    "6" => { label: "Движение по маршруту вперёд", func: :train_move_forward },
    "7" => { label: "Движение по маршруту назад", func: :train_move_back },
    "8" => { label: "Список всех поездов", func: :show_train_list },
    "0" => { label: "Выход в главное меню", func: :exit_menu }
  }
  ROUTES_MENU = {
    "1" => { label: "Создать маршрут", func: :route_create },
    "2" => { label: "Добавить станцию в маршрут", func: :route_add_station },
    "3" => { label: "Удалить станцию из маршрута", func: :route_del_station },
    "4" => { label: "Список маршрутов", func: :route_list },
    "5" => { label: "Назначить маршрут поезду", func: :train_set_route },
    "0" => { label: "Выход в главное меню", func: :exit_menu }
  }

  def initialize
    @stations = []
    @trains = []
    @routes = []

    main_menu
  end

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

  def station_menu
    !loop { inputs(STATION_MENU) || break }
  end

  def train_menu
    !loop { inputs(TRAIN_MENU) || break }
  end

  def route_menu
    !loop { inputs(ROUTES_MENU) || break }
  end

  def exit_menu
    return
  end

  def ask(question)
    print question + " "
    gets.chomp
  end

  def station_create
    puts 'Создание станции'
    res = @stations.push(Station.new(ask('Введите название станции'))).last
    !puts "=> Создана станция #{res.name}: #{res.inspect}"
  end

  def station_list
    if @stations.empty?
      !puts '=> Станций нет'
    else
      @stations.each.with_index { |s, i| puts "#{i}. Станция #{s.name}, поездов #{s.trains.size}" }
    end
  end

  def route_create
    station_list
    start_index = ask('Укажите номер начальной станции маршрута:').to_i
    finish_index = ask('Укажите номер конечной станции маршрута:').to_i

    route = Route.new(@stations[start_index], @stations[finish_index])
    puts "Создан маршрут #{route_info(route)}"
    @routes.push(route)
  end

  def route_list
    if @routes.empty?
      !puts '=> Маршрутов нет'
    else
      @routes.each.with_index { |r, i| puts "#{i}. Маршрут #{route_info(r)}" }
    end
  end

  def route_info(r)
    points = []
    r.route.each { |r| points.push(r.name) }
    points.join('-')
  end

  def route_add_station
    route_list
    route_index = ask('Выберите номер маршрута:').to_i
    route = @routes[route_index]

    station_list
    station_index = ask('Укажите номер станции для добавления в маршрут:').to_i

    route.add(@stations[station_index])
    puts "=> Станция добавлена, теперь маршрут: #{route_info(route)}"
    route
  end

  def route_del_station
    route_list
    route_index = ask('Выберите номер маршрута:').to_i
    route = @routes[route_index]

    station_list
    station_index = ask('Укажите номер станции для удаления из маршрута:').to_i

    route.del(@stations[station_index])
    puts "=> Станция удалена, теперь маршрут: #{route_info(route)}"
    route
  end

  def station_trains_list
    station_list
    station_index = ask('Введите номер станции, где показать поезда:').to_i
    station = @stations[station_index]
    if station.trains.empty?
      !puts "=> На станции #{station.name} поездов нет"
    else
      puts "=> На станции #{station.name} находятся поезда:"
      station.trains.each { |t| puts "Поезд №#{t.number}, тип: #{t.type}, вагонов: #{t.wagons}" }
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
    show_train_list
    train_index = ask("Укажите индекс поезда для добавления вагонов:").to_i
    wagons_amount = ask("Сколько вагонов добавить?").to_i
    train = @trains[train_index]

    if train.type == :cargo
      wagons_amount.times { train.wagon_add(WagonCargo.new) }
    else
      wagons_amount.times { train.wagon_add(WagonPassenger.new) }
    end
    !puts "=> Вагоны добавлены, #{train_info(train)}"
  end

  def train_del_wagons
    show_train_list
    train_index = ask("Укажите индекс поезда для добавления вагонов:").to_i
    wagons_amount = ask("Сколько вагонов отцепить?").to_i
    train = @trains[train_index]
    wagons_amount.times { train.wagon_del }
    !puts "=> Вагоны отцеплены, #{train_info(train)}"
  end

  def train_set_route
    route_list
    route_index = ask('Выберите номер маршрута:').to_i
    route = @routes[route_index]

    show_train_list
    train_index = ask("Укажите индекс поезда для назначения маршрута:").to_i
    train = @trains[train_index]
    train.route_set(route)
    !puts "=> Поезду №#{train.number} установлен маршрут #{route_info(route)}"
  end

  def train_move_forward
    show_train_list
    train_index = ask("Укажите индекс поезда для движения вперёд").to_i
    train = @trains[train_index]
    train.move_forward
    !puts "=> Поезд №#{train.number} уехал со станции #{train.prev_station.name} и приехал на станцию #{train.current_station.name}. Следующая станция #{train.next_station.name}"
  end

  def train_move_back
    show_train_list
    train_index = ask("Укажите индекс поезда для движения назад").to_i
    train = @trains[train_index]
    train.move_back
    !puts "=> Поезд №#{train.number} уехал со станции #{train.next_station.name} и приехал на станцию #{train.current_station.name}. Следующая станция #{train.prev_station.name}"
  end

  def show_train_list
    if @trains.empty?
      !puts "=> Поездов нет"
    else
      @trains.each.with_index { |t, i| puts "#{i}. #{train_info(t)}" }
    end
  end

  def train_info(train)
    "поезд №#{train.number}, тип: #{train.type}, вагонов: #{train.wagons}"
  end

end
