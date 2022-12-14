month_days = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]


puts "Enter the day please"
day = gets.chomp.to_i

if day > 31 || day <= 0
  puts "Enter the correct day"
  return
end

puts "Enter the month please"
month = gets.chomp.to_i

if month > 12 || month <= 0 || (day > month_days[month-1])
  puts "Enter the correct date"
  return
end

puts "Enter the year please"
year = gets.chomp.to_i

if year < 0
  puts "Enter the correct year"
  return
end

def is_leap_year(year)
  if year % 4 == 0
    if year % 100 == 0
      if year % 400 == 0
        true
      end
    else
      true
    end
  end
end

if !is_leap_year(year) && month == 2 && day > 28
  puts "Enter the correct date"
  return
end


sequence_number = day

for i in 1..month-1 do
  sequence_number += month_days[i-1]
end

if is_leap_year(year) || month == 1 || month == 2
  puts "The day has #{sequence_number} sequence number"
else
  puts "The day has #{sequence_number-1} sequence number"
end
