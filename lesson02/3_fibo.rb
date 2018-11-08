# Заполнить массив числами фибоначчи до 100
MAX = 100
fibo = [0, 1]

loop do
  nextnum = fibo.last(2).sum
  break if nextnum > MAX
  fibo.push(nextnum)
end

puts fibo.to_s
