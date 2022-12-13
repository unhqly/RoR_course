letters = Hash.new

for i in 'a'..'z' do
  if i == 'a' || i == 'e' || i == 'i' || i == 'o' || i == 'u'
    letters[i] = i.bytes.first.to_i - 96
  end
end

puts letters