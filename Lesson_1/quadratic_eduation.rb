puts "Enter a coefficient"
a = gets.chomp.to_f

puts "Enter b coefficient"
b = gets.chomp.to_f

puts "Enter c coefficient"
c = gets.chomp.to_f

d = (b**2 - 4 * a * c)

if d < 0 
    puts "Discriminant is #{d} and there're no roots"
elsif d == 0
    x = -b / 2 * a
    puts "Discriminant is #{d} and there's the only root - #{x}"
else
    x1 = -b + Math.sqrt(d) / 2 * a
    x2 = -b - Math.sqrt(d) / 2 * a
    puts "Discriminant is #{d} and there're two roots: #{x1}, #{x2}"
end

#don't know, how to process case with a, b, c = 0. result is x = -0.0 :)
