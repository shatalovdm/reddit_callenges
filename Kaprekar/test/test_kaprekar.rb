require 'minitest/autorun'
require 'kaprekar'

class TestKaprekar < Minitest::Test
	def setup
		@k = Kaprekar.new
	end
	def test_largest_digit
		assert_equal(1, @k.largest_digit(1))
		assert_equal(2, @k.largest_digit(12))
		assert_equal(3, @k.largest_digit(123))
		assert_equal(4, @k.largest_digit(1234))
		assert_raises ArgumentError do 
			@k.largest_digit(12345)
		end
	end
	def test_desc_digits
		assert_equal(1, @k.desc_digits(1))
		assert_equal(12, @k.desc_digits(21))
		assert_equal(223, @k.desc_digits(232))
		assert_equal(1234, @k.desc_digits(4321))
		assert_raises ArgumentError do 
			@k.largest_digit(12345)
		end
	end
	def test_kaprekar
		assert_equal(2, @k.kaprekar(6589))
		assert_equal(3, @k.kaprekar(1234))
		assert_equal(0, @k.kaprekar(6174))
	end

end