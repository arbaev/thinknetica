require_relative 'menus_commands'

class Menus
  include MenusCommands

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
      command_hash = @current_menu[user_input]
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

  def user_input
    gets.chomp.to_s
  end

  def exit_menu;
    abort
  end
end
