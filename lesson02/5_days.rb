# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года. 
# Учесть, что год может быть високосным. (Запрещено использовать встроенные
# в ruby методы для этого вроде Date#yday или Date#leap?) 

def leap?(year)
  return true if year % 400 == 0
  return false if year % 100 == 0
  year % 4 == 0
end

def howmanydays(year, month, day)
  months = {
    1 => 31, 2 => 28, 3 => 31, 
    4 => 30, 5 => 31, 6 => 30,
    7 => 31, 8 => 31, 9 => 30,
    10 => 31, 11 => 30, 12 => 31
  }
  
  days = day + months.reduce(0) do |acc, m|
    acc += m.last if m.first < month
    acc
  end

  leap?(year) ? days + 1 : days
end

puts "Определим порядковый номер указанной даты"
print "Введите год "
year = gets.chomp.to_i
print "Введите номер месяца "
month = gets.chomp.to_i
print "Введите день месяца "
day = gets.chomp.to_i

puts howmanydays(year, month, day)
