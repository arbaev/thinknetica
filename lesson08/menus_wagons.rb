# console menu command methods for class Wagon
module MenusWagons
  private

  def show_wagons
    return if show_trains.nil?

    train = get_selected_from(@trains)
    raise ArgumentError, 'У поезда нет вагонов' if train.wags.empty?

    show_wagons_list(train)
  rescue ArgumentError => e
    puts e.message
  end

  def show_wagons_list(train)
    i = 0
    train.each_wagon do |wag|
      i += 1
      puts "#{i}. #{wagon_info(wag)}"
    end
  end

  def wagon_info(wagon)
    if wagon.type == :cargo
      "тип: #{wagon.type}, свободно #{wagon.capacity_free} м3, \
занято #{wagon.capacity_occupied} м3"
    else
      "тип: #{wagon.type}, свободно #{wagon.seats_free} мест, \
занято #{wagon.seats_occupied} мест"
    end
  end

  def train_load_wagon
    wagons = show_wagons
    return if wagons.nil?

    wagon = get_selected_from(wagons)
    if wagon.type == :cargo
      load = ask('Сколько кубометров желаете занять? ').to_f
      wagon.take_capacity(load)
    else
      load = ask('Сколько мест желаете занять? ').to_i
      load.times { wagon.take_seat }
    end
    puts wagon_info(wagon)
  rescue ArgumentError => e
    puts e.message
  end
end
