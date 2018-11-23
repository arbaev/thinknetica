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
  @tc = TrainCargo.new(1)
  @tp = TrainPassenger.new(10)

  @wc1 = WagonCargo.new
  @wc2 = WagonCargo.new
  @wc3 = WagonCargo.new
  @wp1 = WagonPassenger.new
  @wp2 = WagonPassenger.new
  @wp3 = WagonPassenger.new

  @s1 = Station.new("mos")
  @s2 = Station.new("ekb")
  @s3 = Station.new("nsk")
  @s4 = Station.new("spb")

  @r1 = Route.new(@s1, @s4)

  @tc.route_set(@r1)
end


menus = Menus.new
