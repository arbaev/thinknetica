require_relative 'menus_commands'
require_relative 'menus_stations'
require_relative 'menus_routes'
require_relative 'menus_trains'
require_relative 'menus_wagons'
# console menu class
class Menus
  include MenusCommands
  include MenusStations
  include MenusRoutes
  include MenusTrains
  include MenusWagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @current_menu = MAIN_MENU
    menu
  end

  def menu
    loop do
      showmenu(@current_menu)
      command_hash = @current_menu[ask('?>').to_s]
      command_hash.nil? ? unknown_command : run_command(command_hash)
    end
  end

  private

  def change_menu(new_menu = MAIN_MENU)
    @current_menu = new_menu
  end

  def run_command(command_hash)
    func = command_hash[:func]
    arguments = command_hash[:args]
    arguments.nil? ? send(func) : send(func, arguments)
  end

  def unknown_command
    puts '=> unknown command'
  end

  def showmenu(menu)
    puts '==================='
    menu.each { |k, v| puts "#{k} - #{v[:label]}" }
    puts '==================='
  end

  def ask(question)
    print question + ' '
    gets.chomp
  end

  def ask_i(question = '')
    print question + ' '
    i = gets.chomp.to_i
    return TOO_LONG if i.zero?

    i - 1 # because array index from zero but listings from one
  end

  def get_selected_from(arr)
    return if arr.nil?

    if arr.size == 1
      puts '=> ^^^^^^ Единственный вариант, выбран автоматически'
      return arr.first
    end
    item = arr[ask_i('Выберите номер объекта:')]
    correct?(item) ? item : raise(ArgumentError, '=> Неправильно указан номер')
  end

  def correct?(value)
    !value.nil?
  end

  def exit_menu
    abort
  end
end
