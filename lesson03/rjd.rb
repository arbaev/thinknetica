require_relative "lib/train.rb"
require_relative "lib/route.rb"
require_relative "lib/station.rb"

puts "СОЗДАНИЕ"
t1 = Train.new(1, :freight, 44)
t2 = Train.new(2)
t3 = Train.new(3, :passenger)
t4 = Train.new(4, :passenger)
t5 = Train.new(5, :passenger, 10)

r1 = Route.new("mos", "yarsk")
r2 = Route.new("nsk", "spb")

r1.add_after("mos", "ekb")
r1.add_after("m", "saratov")
r1.add_after("yarsk", "saratov")


puts "ТЕСТЫ"
t1.route_set(r1)
t1.move_forward
t1.move_forward

t2.route_set(r2)
t2.move_back
t2.move_forward
t2.move_back

t2.current.list_types
