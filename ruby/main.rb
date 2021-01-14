require './lib/bibliography_list.rb'

puts "Enter number of names:"
a = gets.chomp

fullnames = []
puts "Enter the names:"
for _ in 1..a.to_i
  fullnames << gets.chomp
end

def main(fullnames)
  if fullnames.size == 0
    puts "----"
    puts "Response: 0 or not a integer was inputed: nothing to do"
  end

  bibliography_list = BibliographyList.new(fullnames)

  puts
  puts "Response:"
  puts bibliography_list.format_fullnames
end

main(fullnames)
