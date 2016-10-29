# Challenge #287 [Easy] Kaprekar's Routine

class Kaprekar
	def create_array(input)
		input_splitted = input.to_s.split("")
		final_array = []
		if input_splitted.length < 4
			final_array = (["0","0", "0"] + input_splitted).pop(4)
		elsif input_splitted.length == 4
			final_array = input_splitted
		else 
			raise "Wrong number"
		end
		final_array
	end

	# A function that, given a 4-digit number, returns the largest digit in that number. 
	# Numbers between 0 and 999 are counted as 4-digit numbers with leading 0's.

	def largest_digit(input)
		create_array(input).max.to_i
	end

	# A function that, given a 4-digit number, performs the "descending digits" operation.
	# This operation returns a number with the same 4 digits sorted in descending order.

	def desc_digits(input)
		create_array(input).sort.join.to_i
	end

	# A function that counts the number of iterations in Kaprekar's Routine

	def kaprekar(input)
		def aux (input, count)
			case input 
			when 6174
				count
			when 0
				puts "Wrong number"
			else
				count += 1
				array = input.to_s.split("").sort
				asc_number = array.join.to_i
				desc_number = array.reverse.join.to_i
				aux(desc_number - asc_number, count)
			end
		end
		aux(input, 0)
	end
end
