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
  @tc = TrainCargo.new(111)
  @tc = TrainCargo.new('tri-ko')
  @tp = TrainPassenger.new('101-kv')
  @tp = TrainPassenger.new('333-R5')

  @wc1 = WagonCargo.new(5.5)
  @wc2 = WagonCargo.new(12)
  @wc3 = WagonCargo.new(0.4)
  @wp1 = WagonPassenger.new(10)
  @wp2 = WagonPassenger.new(5)
  @wp3 = WagonPassenger.new(22)

  @s1 = Station.new("mos")
  @s2 = Station.new("ekb")
  @s3 = Station.new("nsk")
  @s4 = Station.new("spb")

  @r1 = Route.new(@s1, @s4)
  @r1.add(@s2)
  @r1.add(@s3)
  @r2 = Route.new(@s3, @s2)

  @tc.route_set(@r1)
end

seed
menus = Menus.new
