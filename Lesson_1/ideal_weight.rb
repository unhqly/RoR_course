puts "Enter your name please"
name = gets.chomp

puts "Enter your height please"
height = gets.chomp.to_f

optimal_weight = (height - 110) * 1.15

if optimal_weight < 0
    puts "#{name}, you have an optimal weight already"
else
    puts "#{name}, your optimal weight is #{optimal_weight}"
end