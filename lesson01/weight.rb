print "Ваше имя? "
name = gets.chomp.capitalize
print "Ваш рост в см? "
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight > 0
  puts "#{name}, ваш идеальный вес - #{ideal_weight} кг."
else
  puts "#{name}, ваш вес уже оптимальный"
end