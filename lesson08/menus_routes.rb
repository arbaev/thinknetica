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
    stations = show_stations
    if stations.nil? || stations.size < 2
      puts '=> маршрут нельзя задать'
      return
    end
    puts 'Начальная станция'
    start = get_selected_from(stations)
    puts 'Конечная станция'
    finish = get_selected_from(stations)
    raise ArgumentError, 'Такой маршрут уже существует' if route_exist?(start, finish)

    route = Route.new(start, finish)
    puts "Создан маршрут #{route_info(route)}"
    @routes.push(route)
  rescue ArgumentError => e
    puts e.message
    retry
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
    if route.length == 2
      raise ArgumentError, '=> Промежуточных станций нет, нечего удалять'
    end
    stations_in_route = show_stations(route.route)
    station = get_selected_from(stations_in_route)
    route.del(station)
    puts "=> Станция удалена, теперь маршрут: #{route_info(route)}"
    route
  rescue ArgumentError => e
    puts e.message
  end
end
