# Given a list of numbers, find two that add up to 2020.  Return
# the product of those numbers

def answer(input_nums)
  ans = input_nums.reduce(input_nums) do |list, a|

    rest_of_list = list.drop(1)

    b = rest_of_list.find do |x|
      a + x == 2020
    end

    if b.nil?
      rest_of_list
    else
      break b * a
    end
  end

  puts "Answer is #{ans}"
end


puts answer(File.open(ARGV.first).read.split(/\n/).map(&:to_i))