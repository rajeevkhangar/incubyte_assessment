require 'string_calculator'

RSpec.describe StringCalculator do

  describe '#' do
    it "does work" do
      expect(described_class).to be StringCalculator
    end
  end

  describe '#add' do
    it "should respond to method" do
      expect(described_class.respond_to?(:add)).to be_truthy
    end

    it 'should accept a string' do
      expect{ described_class.add('1,2,3') }.not_to raise_error
    end

    it 'should not accept other data types' do
      expect{ described_class.add(123) }.to raise_error('only accepts a string')
      expect{ described_class.add(['123']) }.to raise_error('only accepts a string')
    end

    it 'should return 0 for an empty string' do
      expect(described_class.add('')).to eq(0)
    end

    it 'should return a number if the passes string contains no delimiters' do
      expect(described_class.add('123')).to eq (123)
    end


    it 'should return the sum of the numbers in the passed string, if the passed string contains comma delimiters' do
      expect(described_class.add('1,2,3,4')).to eq(10)
    end

    it 'should return the sum of the numbers in the passed string, if the passed string contains [",", "\n"] delimiters' do
      expect(described_class.add('1\n2, 3')).to eq(6)
    end

    it 'should return the sum of the numbers in the passed string, if the passed string contains ["//;\n", "\n", ";"] delimiters' do
      expect(described_class.add('//;\n1;2, 3\n4, 5')).to eq(15)
    end

    it 'returns exception if the passed string contains single negative number' do
      expect{described_class.add('1\n2, -3')}.to raise_error('negative numbers not allowed -3')
    end

    it 'returns exception if the passed string contains multiple negative numbers' do
      expect{described_class.add('1\n2, -3, -4')}.to raise_error('negative numbers not allowed -3,-4')
    end
  end

  describe "#check_for_negatives" do
    it 'returns one negative number if passed integer_array has on negative number' do
      expect(described_class.send(:check_for_negatives, [1, -2])).to eq("-2")
    end

    it 'returns multiple negative numbers if passed integer_array has many negative numbers' do
      expect(described_class.send(:check_for_negatives, [1, -2, 3, -4])).to eq("-2,-4")
    end

    it "returns false if passed integer_array doesn't have negative number" do
      expect(described_class.send(:check_for_negatives, [1, 2, 3, 4])).to be false
    end
  end
end
