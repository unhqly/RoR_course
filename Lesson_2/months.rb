months = {
  "january" => 31,
  "february" => 28,
  "march" => 31,
  "april" => 30,
  "may" => 31,
  "june" => 30,
  "jule" => 31,
  "august" => 31,
  "september" => 30,
  "october" => 31,
  "november" => 30,
  "december" => 31
}

puts "Months with 30 days:"
months.each { |month, number_of_days| puts month if number_of_days == 30 }