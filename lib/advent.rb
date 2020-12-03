require_relative 'output_help'

def default_input(dir=__dir__)
  File.open(File.expand_path('input.txt', dir)).read
end