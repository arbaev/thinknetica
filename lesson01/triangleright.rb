puts "Определим свойства треугольника"
print "Введите длину первой стороны треугольника "
a = gets.chomp.to_f
print "Введите длину второй стороны треугольника "
b = gets.chomp.to_f
print "Введите длину третьей стороны треугольника "
c = gets.chomp.to_f

aa,bb,cc = [a*a, b*b, c*c].sort.map {|x| x.round(2)}

return puts "не существует" unless a + b > c && a + c > b && b + c > a
return puts "равносторонний" if a == b && b == c 

properties = 0
properties += 1 if aa + bb == cc
properties += 2 if a == b || b == c || c == a

case properties
when 0
  puts "не прямоугольный"
when 1
  puts "прямоугольный"
when 2
  puts "не прямоугольный, равнобедренный"
when 3
  puts "прямоугольный, равнобедренный"
end
