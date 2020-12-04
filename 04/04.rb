require_relative '../lib/advent.rb'


REQ = %w{byr iyr eyr hgt hcl ecl pid }

def valid?(passport)
  REQ.all? {|x| passport.include?("#{x}:") }
end

def count_valid_passports(passports)
  passports.reduce(0) do |count, passport|
    one_line_passport = passport.gsub(/\n/,'')
    if valid?(one_line_passport)
      pprint "VALID ", color: :green
      count += 1
    else
      pprint "INVALID ", color: :red
    end
      pputs one_line_passport
    count
  end
end


def solution(read_file)
  section_header("Day 4")
  passports = read_file.split(/\n\n/)

  pputs "Calculating part 1"
  horizontal_rule
  valid_passports = count_valid_passports(passports)

  # pputs "Calculating part 2"
  # horizontal_rule
  # slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
  # trees_on_paths = calc_trees_on_paths_for_slopes(map, slopes)
  # product_of_trees_on_paths = trees_on_paths.reduce(:*)

  pprint "Part 1: ", color: :cyan
  pputs "#{valid_passports}", color: :blue, style: :bold

  # pprint "Part 2: ", color: :cyan
  # pputs product_of_trees_on_paths, color: :blue, style: :bold

end

solution(ARGV.first || default_input(__dir__))