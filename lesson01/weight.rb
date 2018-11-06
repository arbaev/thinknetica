print "Ваше имя? "
name = gets.chomp.capitalize
print "Ваш рост в см? "
height = gets.chomp.to_i.-110

puts (height > 0 ? "#{name}, ваш идеальный вес - #{height} кг." : "#{name}, ваш вес уже оптимальный")