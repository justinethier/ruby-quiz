require 'edit_text.rb'
require 'test/unit'

class TestTextLineBuffer < Test::Unit::TestCase
  def test_text_line_buffer
    line = TextLineBuffer.new("")
    
    line.insert_before('a')
    line.insert_before('b')
    line.insert_before('c')
    assert_equal("abc", line.to_s)
    
    line.insert_after('f')
    line.insert_after('e')
    line.insert_after('d')
    assert_equal("abcdef", line.to_s)
    
    assert_equal('c', line.delete_before)
    assert_equal("abdef", line.to_s)
    
    assert_equal('d', line.delete_after)
    assert_equal("abef", line.to_s)
    
    assert_equal('a', line.left)
    assert_equal(nil, line.left)
    assert_equal('a', line.delete_after)
    assert_equal("bef", line.to_s)    
    
    assert_equal(nil, line.delete_before)
    assert_equal('e', line.right)
  end
  
  def test_text_buffer
    # TODO: TextBuffer
    assert false
  end
end