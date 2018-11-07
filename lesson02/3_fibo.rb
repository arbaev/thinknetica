# Заполнить массив числами фибоначчи до 100
MAX = 100
fibo = [0, 1]

loop do
  j,k = fibo.last(2)
  break if j+k > MAX
  fibo.push(j+k)
end

puts fibo.to_s
