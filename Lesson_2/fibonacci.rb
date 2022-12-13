fibonacci_array = [0, 1]

for index in 2..100 do
  fibonacci_array << fibonacci_array[index-2] + fibonacci_array[index-1]
end

puts fibonacci_array