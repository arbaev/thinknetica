# console menu command methods for class Station
module MenusStations
  private

  def show_stations(arr = @stations)
    raise ArgumentError, '=> Станций нет' if arr.empty?

    arr.each.with_index(1) { |s, i| puts "#{i}. #{show_station_info(s)}" }
  rescue ArgumentError => e
    puts e.message
  end

  def show_station_info(station)
    "Станция #{station.name}, поездов #{station.trains.size}"
  end

  def station_create
    station = Station.new(ask('Введите название станции:'))
    puts "=> Создана станция #{station.name}"
    @stations.push(station)
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def station_trains_list
    return if show_stations.nil?

    station = get_selected_from(@stations)
    show_station_trains(station)
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def show_station_trains(station)
    if station.trains.empty?
      puts "=> На станции #{station.name} поездов нет"
    else
      puts "=> На станции #{station.name} находятся поезда:"
      station.each_train { |t| puts train_info(t) }
    end
  end
end
