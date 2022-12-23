products = {}
total = 0

while true do
  puts "Enter the name of product"
  name = gets.chomp
  
  break if name == "stop"

  puts "Enter the price of product"
  price = gets.chomp.to_f

  puts "Enter amount of products"
  amount = gets.chomp.to_f

  products[name] = {price => amount}
end


if products
  products.each_key do |product| 
    print "#{product} => "
    products[product].each_pair do |price, amount| 
      puts "#{price} => #{amount}, sum = #{price * amount}"
      total += price * amount
    end
  end
end

#another output
#products.each_key do |product| 
#  print "#{product}: "
#  products[product].each_pair { |price, amount| puts "price = #{price}, amount = #{amount}, sum = #{price * amount}"} 
#end

puts "total sum = #{total}" if total != 0