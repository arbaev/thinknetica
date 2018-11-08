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
  days_of_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  days_of_months[1] = 29 if leap?(year)

  day + days_of_months.take(month - 1).sum
end

puts "Определим порядковый номер указанной даты"
print "Введите год "
year = gets.chomp.to_i
print "Введите номер месяца "
month = gets.chomp.to_i
print "Введите день месяца "
day = gets.chomp.to_i

puts howmanydays(year, month, day)
