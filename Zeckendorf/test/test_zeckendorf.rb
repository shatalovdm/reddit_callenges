require 'zeckendorf'
require 'minitest/autorun'

class TestZeckendorf < Minitest::Test
	def setup
		@z = Zeckendorf.new
	end
	def test_members
		assert_equal([89, 21, 8, 2], @z.find_members(120))
		assert_equal([34], @z.find_members(34))
		assert_equal([55, 21, 8, 3, 1], @z.find_members(88))
		assert_equal([89, 1], @z.find_members(90))
		assert_equal([233, 55, 21, 8, 3], @z.find_members(320))
		assert_equal([0], @z.find_members(0))
		assert_equal([1], @z.find_members(1))
	end
end
