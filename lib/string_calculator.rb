class StringCalculator

  DELIMITERS = {'//;\n': '', '\n': ',', ';': ','}.freeze

  def self.add(string_of_numbers="")
    raise 'only accepts a string' unless string_of_numbers.is_a?(String)

    DELIMITERS.each { | key, value | string_of_numbers = string_of_numbers.gsub(key.to_s, value) }
    integer_array = string_of_numbers.split(/[^0-9-]+/).map(&:to_i)

    raise "negative numbers not allowed #{check_for_negatives(integer_array)}" if check_for_negatives(integer_array)

    integer_array.inject(0){|sum, number| sum + number }
  end

  private

  def self.check_for_negatives(integer_array)
    negatives_array = integer_array.select{ |i| i < 0 }
    negatives_array.any? ? negatives_array.join(",") : false
  end
end

