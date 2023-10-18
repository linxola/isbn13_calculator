puts 'Hello! This program is used to calculate the check digit of an ISBN13 barcode.'
print 'Please enter your ISBN: '
isbn = gets.chomp
raise StandardError, 'Wrong ISBN!' unless isbn.match?(/^\d{13}$/)

sum = 0
isbn.chars.map(&:to_i).each_with_index do |digit, index|
  sum += index.even? ? digit * 1 : digit * 3
end

result = 10 - (sum % 10)
result = 0 if result == 10

puts "Check digit of #{isbn} ISBN is: #{result}"
