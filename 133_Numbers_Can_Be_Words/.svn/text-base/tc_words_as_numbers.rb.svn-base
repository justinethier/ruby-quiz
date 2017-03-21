# Justin Ethier
# 
# Unit Tests and Test Code for:
# Ruby Quiz 133
# http://www.rubyquiz.com/quiz133.html
# 
$:.unshift File.join(File.dirname(__FILE__), "..")
require 'test/unit'
require 'words_as_numbers.rb'

class TestWordsAsNumbers< Test::Unit::TestCase
  def test_regex
    regexp = Regexp.new("^([a-y])+$", "i")
    assert(regexp.match("cAt"))
    assert_equal(nil, regexp.match("zoo"))
  end
end
