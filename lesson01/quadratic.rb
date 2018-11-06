puts "Решение квадратного уравнения."
print "Введите коэффициент a "
a = gets.chomp.to_f

return puts "Ошибка! Коэффициент 'a' не может быть равен нулю" if a == 0

print "Введите коэффициент b "
b = gets.chomp.to_f
print "Введите коэффициент c "
c = gets.chomp.to_f

d = b*b - 4*a*c

if d > 0
  d_sqrt = Math.sqrt(d)
  x1 = (-b - d_sqrt)/(2*a)
  x2 = (-b + d_sqrt)/(2*a)
  puts "D=#{d}, x1=#{x1}, x2=#{x2}"
elsif d == 0
  x1 = -b/2*a
  puts "D=#{d}, x1=x2=#{x1}"
else
  puts "D=#{d}, корней нет"
end
