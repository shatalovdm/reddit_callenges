
=begin
Challenge #286 [Intermediate] Zeckendorf Representations of Positive Integers

Zeckendorf's theorem states that every positive integer can be represented uniquely as the sum of one or more distinct Fibonacci numbers 
in such a way that the sum does not include any two consecutive Fibonacci numbers.

The program emits the Zeckendorf representation for each of the given numbers.
=end

class Zeckendorf
	# Find Fibonacci number
	def fib (number)
		number <= 1 ? number :  fib( number - 1 ) + fib( number - 2 )
	end

	# Find the largest Fibonnaci number that is less than the provided number
	def find_largest(number, n, fib_n)
		first = fib(n)
		second = first + fib_n
		first <= number && second > number ? first : find_largest(number, n + 1, first)
	end

	# Find all the members of the Zeckendorf representation for the provided number
	def find_members(number)
		results = []
		if number == 0
			results << number 
		else
			while number > 0
				member = find_largest(number, 0, 1)
				results << member 
				number -= member
			end
		end
		results
	end

	# Read the provided numbers and print the Zeckendorf representation
	def read_and_print_members
		number_of_lines = (ARGV[0]).to_i
		numbers = []
		while number_of_lines > 0
			numbers << $stdin.gets.chomp.to_i
			number_of_lines -= 1
		end

		numbers.each do |number|
			results = find_members(number)
			printf "%d = %d ", number, results.shift
			results.each do |result|
				printf "+ %d ", result
			end
			puts
		end
	end
	private :fib, :find_largest
end
z = Zeckendorf.new
z.read_and_print_members