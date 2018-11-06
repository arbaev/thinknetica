puts "Проверим ваш треугольник."
print "Введите длину первой стороны треугольника "
a = gets.chomp.to_f
print "Введите длину второй стороны треугольника "
b = gets.chomp.to_f
print "Введите длину третьей стороны треугольника "
c = gets.chomp.to_f

a,b,c = [a*a, b*b, c*c].sort.map {|x| x.round 2}

if a + b == c
  print "Треугольник прямоугольный "
  puts "и равнобедренный" if a == b
else
  print "Треугольник не прямоугольный"
  if a == b && b == c
    puts ", но равносторонний"
  elsif a == b || b == c || c == a
    puts ", но равнобедренный"
  end
end
