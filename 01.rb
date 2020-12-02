# Given a list of numbers, find sets of two and three that add up to 2020
# Return the product of those sets

def answer(input_nums)
  [2,3].each do |set_size|
    all_combinations = input_nums.combination(set_size)

    target_set = all_combinations.to_a.find do |x|
      x.sum == 2020
    end

    puts "Answer for set size #{set_size} is #{target_set.reduce(:*)}"
  end
end

answer(File.open(ARGV.first).read.split(/\n/).map(&:to_i))