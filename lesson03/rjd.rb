require_relative "lib/train.rb"
require_relative "lib/route.rb"
require_relative "lib/station.rb"

puts "СОЗДАНИЕ"
t1 = Train.new(88, :freight)
t2 = Train.new(90)
t3 = Train.new(28, :passenger)
t4 = Train.new(10, :passenger)
t5 = Train.new(1, :passenger, 10)

s1 = Station.new("mos")
s2 = Station.new("ekb")

r1 = Route.new(["mos", "kaz", "omsk", "yarsk"])
r2 = Route.new(["nsk", "ola", "ekb", "spb"])

puts "ТЕСТЫ"
s1.arrive(t1)
s1.arrive(t2)
s1.arrive(t3)
s1.arrive(t5)
t5.route_set(r1)
t5.route_info
t5.move_back
t5.move_forward
s1.departure(t5)
s1.departure(t4)
s1.list
s1.list_by_type
t9 = Train.new(155, :mail, 55)
s1.arrive(t9)
s1.list_by_type
