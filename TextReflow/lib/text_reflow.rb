=begin
Challenge #279 [Intermediate] Text Reflow

The program breaks up lines of text so that they fit within a certain width. It is useful in e.g. mobile browsers.
When you zoom in on a web page the lines will become too long to fit the width of the screen,
unless the text is broken up into shorter lines.

It also gets rid of the jagged right margin of the text and make the output prettier.
The program adjusts the word spacing so that the text is flush against both the left and the right margin.

=end

class TextReflow

  def initialize(input_file, line_width = 40)
    unless File.file?(input_file)
      raise IOError, "not found"
    end
    @input_file = input_file
    @line_width = line_width
  rescue IOError => error
    puts "Error: File \"#{input_file}\" #{error.message}"
  end

  # Adjusts spacing for a line unless is already properly spaced
  def adjust_spacing(line)
    joined_line = line.join(' ')

    unless joined_line.length == @line_width
      # Find number of spaces needed
      spaces = (@line_width - joined_line.length)

      # Take the last word from the array as we don't want to have spaces following it
      last_word = line.pop

      # Add spaces to the random words from the array
      spaces.times do
        random_word = line.sample
        line.map! do |word|
          if word == random_word
            word << ' '
            break
          else
            word
          end
        end
      end

      # Add the last word to the concatenated list and the return the text line
      joined_line = line.push(last_word).join(' ')
    end
    joined_line
  end

  # Goes through the lines and handle each case
  def break_lines(lines)
    output = []
    extra_line = []
    lines.each do |line|
      if line.chomp.empty?
        output << ['']
        next
      end
      unless extra_line.empty?
        line = extra_line.join(' ') + ' ' + line
        extra_line.clear
      end

      # The words exceeding LINE_WIDTH limit are added to the next line
      if line.chomp.length > @line_width
        words = line.split(' ')
        result_line_1 = []
        result_line_2 = []
        result_count = 0
        words.each do |word|
          result_count += word.length + 1
          if result_count <= (@line_width + 1)
            result_line_1 << word
          elsif result_count > (@line_width + 1) and result_count < @line_width * 2
            result_line_2 << word
          else
            extra_line << word
          end
        end
        output << result_line_1 << result_line_2
      else
        output << line.split(' ')
      end
    end
    p output
    output
  end

  # Opens files for reading input and writing output of the program
  def reflow
    input = File.open(@input_file, "r")
    output = File.open('output_text.txt', "w")
    lines = input.readlines
    input.close

    breaked_lines = break_lines(lines)
    breaked_lines.each { |breaked_line| pretty_line = adjust_spacing(breaked_line); output.write(pretty_line + "\n")}
    output.close
  end
end
