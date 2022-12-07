puts "Enter the length of a side"
a_side = gets.chomp.to_f

puts "Enter the length of b side"
b_side = gets.chomp.to_f

puts "Enter the length of c side"
c_side = gets.chomp.to_f

unless a_side > 0 && b_side > 0 && c_side > 0
    puts "Enter correct triangle"
    return
end

def is_right_triangle(a, b, c)
    if a > b
        if a > c
            if a ** 2 == b ** 2 + c ** 2
                true
            end
        end
    elsif b > c
        if b ** 2 == a ** 2 + c ** 2
            true
        end
    elsif c ** 2 == a ** 2 + b ** 2
            true
    else
        false
    end
end

if (a_side == b_side) || (a_side == c_side) || (b_side == c_side)
    if (a_side == b_side) && (a_side == c_side)
        puts "Triangle is isosceles and quilateral"
        return
    elsif is_right_triangle(a_side, b_side, c_side)
        puts "Triangle is right and isosceles"
        return
    else
        puts "Triangle is isosceles"
        return
    end
end

if is_right_triangle(a_side, b_side, c_side)
    puts "Triangle is right" 
else
    puts "Triangle isn't right, isosceles or quilateral"
end