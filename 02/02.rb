def valid?(policy, password)
  target_letter = policy.slice!(-1)
  min, max = policy.strip.split('-').map(&:to_i)
  occurrences = password.count(target_letter)

  occurrences.between?(min, max)
end

def answer(passwords)
  total_valid = passwords.reduce(0) do |count, password_string|
    if valid?(*password_string.split(':'))
      count += 1
    end
    count
  end

  puts "There are #{total_valid} valid passwords"

end

answer(File.open(ARGV.first).read.split(/\n/))