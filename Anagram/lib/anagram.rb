=begin
Challenge #283 [Easy] Anagram Detector

The program is given two words or sets of words separated by a question mark.
It replaces the question mark with information about the validity of the anagram.

=end
class Anagram

  def compare (letters_1, letters_2)
    if letters_1.empty?
      true
    else
      member = letters_2.shift
      if !letters_1.include?(member)
        false
      else
        letters_1.delete_at(letters_1.index(member))
        compare(letters_1, letters_2)
      end
    end

  end

  def read
    input = $stdin.gets

    # Get the phrases out of the input
    words = input.split('?').map {|word| word.gsub(/'/,'').match(/(\w+)(\s(\w+))*/).to_s}

    # Remove all white spaces and split by letters
    splitted_words = words.map { |word| word.downcase.gsub(/\s+/, '').split('') }

    # Compare letters in two phrases and return the result
    output = compare(splitted_words.first, splitted_words.last) ? ' is an anagram of ' : ' is NOT an anagram of '
    puts words.first + output + words.last
  end

  private :compare
end
@a = Anagram.new
@a.read