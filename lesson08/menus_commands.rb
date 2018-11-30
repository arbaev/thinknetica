module MenusCommands
  CREATING_MENU = {
    '1' => { label: 'Создать станцию', func: :station_create },
    '2' => { label: 'Создать грузовой поезд',
             func: :train_create, args: :cargo },
    '3' => { label: 'Создать пассажирский поезд',
             func: :train_create, args: :passenger },
    '4' => { label: 'Добавить вагоны к поезду', func: :train_add_wagons },
    '5' => { label: 'Создать маршрут', func: :route_create },
    '6' => { label: 'Назначить маршрут поезду', func: :train_set_route },
    '0' => { label: 'Выход в главное меню', func: :change_menu }
  }.freeze
  EDITING_MENU = {
    '1' => { label: 'Добавить вагоны к поезду', func: :train_add_wagons },
    '2' => { label: 'Отцепить вагоны от поезда', func: :train_del_wagons },
    '3' => { label: 'Загрузить вагон', func: :load_wagon_cargo },
    '4' => { label: 'Занять места в вагоне', func: :load_wagon_passenger },
    '5' => { label: 'Добавить станцию в маршрут', func: :route_add_station },
    '6' => { label: 'Удалить станцию из маршрута', func: :route_del_station },
    '7' => { label: 'Назначить маршрут поезду', func: :train_set_route },
    '0' => { label: 'Выход в главное меню', func: :change_menu }
  }.freeze
  MOVING_MENU = {
    '1' => { label: 'Назначить маршрут поезду', func: :train_set_route },
    '2' => { label: 'Движение по маршруту вперёд', func: :train_move_forward },
    '3' => { label: 'Движение по маршруту назад', func: :train_move_back },
    '4' => { label: 'Список маршрутов', func: :show_routes },
    '0' => { label: 'Выход в главное меню', func: :change_menu }
  }.freeze
  INFO_MENU = {
    '1' => { label: 'Список станций', func: :show_stations },
    '2' => { label: 'Список маршрутов', func: :show_routes },
    '3' => { label: 'Список всех поездов', func: :show_trains },
    '4' => { label: 'Список поездов с маршрутом',
             func: :show_trains, args: :current_station },
    '5' => { label: 'Список грузовых поездов',
             func: :show_trains, args: [:type, :cargo] },
    '6' => { label: 'Список пассажирских поездов',
             func: :show_trains, args: [:type, :passenger] },
    '7' => { label: 'Список поездов на станции', func: :station_trains_list },
    '8' => { label: 'Список вагонов поезда', func: :wagons_list },
    '0' => { label: 'Выход в главное меню', func: :change_menu }
  }.freeze
  MAIN_MENU = {
    '1' => { label: 'Создать: станцию, поезд, маршрут',
             func: :change_menu, args: CREATING_MENU },
    '2' => { label: 'Редактировать: поезд, маршрут',
             func: :change_menu, args: EDITING_MENU },
    '3' => { label: 'Движение поезда',
             func: :change_menu, args: MOVING_MENU },
    '4' => { label: 'Информация об объектах',
             func: :change_menu, args: INFO_MENU },
    '0' => { label: 'Выход', func: :exit_menu }
  }.freeze
  TOO_LONG = 99_999_999
end
