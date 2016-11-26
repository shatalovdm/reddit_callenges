require '../lib/text_reflow'
require 'minitest/autorun'


class TestTextReflow < Minitest::Test
  def setup
    @text_1 = TextReflow.new('../lib/text.txt', 40)
    @text_2 = TextReflow.new('../lib/text.txt', 45)
  end

  def test_break_lines
    assert_equal([["In", "the", "beginning", "God", "created", "the", "heavens"], ["and", "the", "earth.", "Now", "the", "earth", "was"]], @text_1.break_lines(['In the beginning God created the heavens and the earth. Now the earth was']))
  end

  def test_adjust_spacing
    assert_equal(40, @text_1.adjust_spacing('In the beginning God created the heavens'.split(' ')).length)
    assert_equal(40, @text_1.adjust_spacing('and the earth. Now the earth was'.split(' ')).length)
    assert_equal(40, @text_1.adjust_spacing('"night." And there was evening, and'.split(' ')).length)
    assert_equal(45, @text_2.adjust_spacing('"night." And there was evening, and'.split(' ')).length)
    assert_equal(45, @text_2.adjust_spacing('and the earth. Now the earth was'.split(' ')).length)
    assert_equal(45, @text_2.adjust_spacing('In the beginning God created the heavens'.split(' ')).length)
  end

end