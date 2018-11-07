# Заполнить хеш гласными буквами, 
# где значением будет порядковый номер буквы в алфавите (a - 1)
vowels = ["a", "e", "y", "u", "i", "o"]
result = Hash.new

("a".."z").map.with_index do |letter, index|
  if vowels.include?(letter)
    result[letter] = index + 1
  end
end

puts result
