require_relative '../lib/advent.rb'


def count_trees_on_path(map, slope_x, slope_y)
  starting_position = [0,0]
  map_height = map.length
  map_width = map.first.length

  coords_to_check = []
  y = 0
  x = 0
  while y < map_height do
    x += slope_x
    y += slope_y
    coords_to_check << [x % map_width,y] # The map loops horizontally, so mod the X
  end

  pputs "Checking slope #{slope_x}, #{slope_y}"

  count = 0
  map.each_with_index do |map_line, i|
    map_line.split('').each_with_index do |char, k|
      color = :green
      if coords_to_check.include?([k,i])
        color = :red

        count += 1 if char == '#'
      end
      pprint char, color: color
    end
    puts ""
  end

  count
end

def calc_trees_on_paths_for_slopes(map, slopes)
  slopes.map do |slope|
    count_trees_on_path(map, slope.first, slope.last)
  end
end


def solution(read_file)
  section_header("Day 3")
  map = read_file.split(/\n/)


  pputs "Calculating part 1"
  horizontal_rule
  trees_on_path = count_trees_on_path(map, 3, 1)

  pputs "Calculating part 2"
  horizontal_rule
  slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
  trees_on_paths = calc_trees_on_paths_for_slopes(map, slopes)
  product_of_trees_on_paths = trees_on_paths.reduce(:*)

  pprint "Part 1: ", color: :cyan
  pputs "#{trees_on_path} trees", color: :blue, style: :bold

  pprint "Part 2: ", color: :cyan
  pputs product_of_trees_on_paths, color: :blue, style: :bold

end

solution(ARGV.first || default_input(__dir__))