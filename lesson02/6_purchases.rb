# Пользователь вводит поочередно название товара, цену за единицу
# и кол-во купленного товара (может быть нецелым числом). 
# Пользователь может ввести произвольное кол-во товаров до тех пор, 
# пока не введет "стоп" в качестве названия товара. 
# На основе введенных данных требуетеся:
# 1. Заполнить и вывести на экран хеш, ключами которого являются 
#    названия товаров, а значением - вложенный хеш, содержащий цену 
#    за единицу товара и кол-во купленного товара. 
#    Также вывести итоговую сумму за каждый товар.
# 2. Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

goods = {}

# обрезает незначащие нули
def trim(float)
  float == float.to_i ? float.to_i : float
end

puts 'Сумма покупок. Выход: стоп или exit'
puts 'Введите название товара, цену за единицу и кол-во купленного товара'
loop do
  print 'Товар: '
  product = gets.chomp.to_s
  break if product == 'стоп' || product == 'exit'

  print 'Цена: '
  price = gets.chomp.to_f
  print 'Количество: '
  quantity = gets.chomp.to_f

  goods[product] = {price: price, quantity: quantity}
end

puts goods
puts "============================"
puts "====== Список товаров ======"
puts "Товар \t| Цена \t| Кол \t| Сумма"

total = 0
goods.each do |el|
  price = trim(el.last[:price])
  quantity = trim(el.last[:quantity])
  sum = trim((price * quantity).round(2))
  puts "#{el.first} \t| #{price} \t| #{quantity} \t| #{sum}"
  total += sum
end

puts "Итого: #{total}"
