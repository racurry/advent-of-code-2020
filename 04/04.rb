require_relative '../lib/advent.rb'


REQ = %w{byr iyr eyr hgt hcl ecl pid }

def valid_field?(field)
  att, val = field.split(':')


  case att
    when 'byr'
      val =~ /^\d{4}$/ && val.to_i.between?(1920,2002)
    when 'iyr'
      (val =~ /^\d{4}$/ && val.to_i.between?(2010,2020))
    when 'eyr'
      val =~ /^\d{4}$/ && val.to_i.between?(2002,2030)
    when 'hgt'
      if val.include?('cm')
        val.to_i.between?(150,193)
      elsif val.include?('in')
        val.to_i.between?(59,76)
      else
        false
      end
    when 'hcl'
      val =~ /#([a-f0-9]{6})/
    when 'ecl'
      val =~ /amb|blu|brn|gry|grn|hzl|oth/
    when 'pid'
      val =~ /^\d{9}$/
    when 'cid'
      true
    else
      raise "unknown att"
    end
end

def valid_passport?(passport, by_field = false)
  has_required_fields = REQ.all? { |x| passport.include?("#{x}:") }
  fields_are_valid = true
  if by_field
    fields = passport.split
    fields_are_valid = fields.all? { |f|
      ret = valid_field?(f)
      pprint f, color: (ret ? :green : :red), indent: 1
      pprint " "
      ret
    }
    puts
  end
  has_required_fields && fields_are_valid
end

def count_valid_passports(passports, field_validation = false)
  passports.reduce(0) do |count, passport|
    one_line_passport = passport.gsub(/\n/,' ')
    if valid_passport?(one_line_passport, field_validation)
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

  pputs "Calculating part 2"
  horizontal_rule
  valid_passports_by_field = count_valid_passports(passports, true)

  pprint "Part 1: ", color: :cyan
  pputs "#{valid_passports}", color: :blue, style: :bold

  pprint "Part 2: ", color: :cyan
  pputs "#{valid_passports_by_field}", color: :blue, style: :bold

end

solution(ARGV.first || default_input(__dir__))