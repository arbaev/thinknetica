# console menu command methods for class Route
module MenusRoutes
  private

  def show_routes(arr = @routes)
    raise ArgumentError, '=> Маршрутов нет' if arr.empty?

    arr.each.with_index(1) { |r, i| puts "#{i}. Маршрут #{route_info(r)}" }
  rescue ArgumentError => e
    puts e.message
  end

  def route_info(route)
    return 'не задан' unless route

    points = []
    route.route.each { |r| points.push(r.name) }
    points.join('-')
  end

  def route_create
    start, finish = ask_route_points
    route = Route.new(start, finish)
    puts "=> Создан маршрут #{route_info(route)}"
    @routes.push(route)
  rescue ArgumentError => e
    puts e.message
  end

  def ask_route_points
    stations = show_stations
    raise ArgumentError, '=> Маршрут нельзя задать' unless route_possible?(stations)

    puts 'Начальная станция'
    start = get_selected_from(stations)
    puts 'Конечная станция'
    finish = get_selected_from(stations)
    raise ArgumentError, '=> Маршрут уже существует' if route_exist?(start, finish)

    [start, finish]
  end

  def route_possible?(stations)
    return if stations.nil?

    stations.size >= 2
  end

  def route_exist?(start, finish)
    !!@routes.find { |r| r.start == start && r.finish == finish }
  end

  def route_add_station
    return if show_routes.nil?

    route = get_selected_from(@routes)
    show_stations
    station = get_selected_from(@stations)
    route.add(station)
    puts "=> Станция #{station.name} добавлена, теперь маршрут: #{route_info(route)}"
    route
  rescue ArgumentError => e
    puts e.message
  end

  def route_del_station
    return if show_routes.nil?

    route = get_selected_from(@routes)
    raise ArgumentError, '=> Промежуточных станций нет' if route.length == 2

    stations_in_route = show_stations(route.route)
    station = get_selected_from(stations_in_route)
    route.del(station)
    puts "=> Станция удалена, теперь маршрут: #{route_info(route)}"
    route
  rescue ArgumentError => e
    puts e.message
  end
end
