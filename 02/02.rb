Counters = Struct.new(:positional, :count_based)

class Password
  def self.from_file_line(file_line)
    policy_string, password = file_line.split(':')
    target_letter = policy_string.slice!(-1)
    first_num, last_num = policy_string.strip.split('-').map(&:to_i)
    new(password, target_letter, first_num, last_num)
  end

  attr_accessor :password

  def initialize(password, target_letter, first_num, last_num)
    @password = password.strip
    @target_letter = target_letter
    @first_num = first_num
    @last_num = last_num
  end

  def valid_with_counters?
    occurrences = @password.count(@target_letter)
    occurrences.between?(@first_num, @last_num)
  end

  def valid_with_positions?
    p1 = @first_num - 1
    p2 = @last_num - 1
    (@password[p1] == @target_letter) ^ (@password[p2] == @target_letter)
  end

  def policy
    "#{@first_num}-#{@last_num} #{@target_letter}"
  end

end

def answer(raw_passwords_data, debug = false)
  passwords = raw_passwords_data.map do |raw_password_data|
    Password.from_file_line(raw_password_data).tap do |password|
      if debug
        puts "Password -#{password.password}-, Policy: #{password.policy}"
        puts "    position: #{password.valid_with_positions? ? 'VALID' : 'INVALID'}"
        puts "    counters: #{password.valid_with_counters? ? 'VALID' : 'INVALID'}"
      end
    end
  end


  total_valid = passwords.reduce(Counters.new(0,0)) do |counters, password|
    counters.positional += 1 if password.valid_with_positions?
    counters.count_based += 1 if password.valid_with_counters?
    counters
  end

  puts "Valid passwords by validation policy:"
  puts "   count-based: #{total_valid.count_based}"
  puts "    positional: #{total_valid.positional}"

end

answer(File.open(ARGV[0]).read.split(/\n/), ARGV[1] == '-d')
