require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'menus'

def seed
  @tc = TrainCargo.new(0)
  @tp = TrainPassenger.new(10)

  @wc1 = WagonCargo.new
  @wc2 = WagonCargo.new
  @wc3 = WagonCargo.new
  @wp1 = WagonPassenger.new
  @wp2 = WagonPassenger.new
  @wp3 = WagonPassenger.new
end


menus = Menus.new
