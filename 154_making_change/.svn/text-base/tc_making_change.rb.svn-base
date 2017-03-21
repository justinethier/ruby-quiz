require 'making_change.rb'
require 'test/unit'

class TestMakingChange< Test::Unit::TestCase
 def test_zero
   assert_equal([], make_change(0))
 end

 def test_change_equal_to_one_coin
   assert_equal([10], make_change(10, [10, 7, 1]))
   assert_equal([7], make_change(7, [10, 7, 1]))
 end

  def test_change
    assert_equal([25, 10, 1, 1, 1, 1], make_change(39))
    assert_equal([7, 7], make_change(14, [10, 7, 1]))
    assert_equal([25, 25, 25, 10, 10, 1, 1, 1, 1], make_change(99))
    
    assert_equal([7, 7], make_change( 14, [10,7,3]))
    
    assert_equal([8,8,8], make_change(24,[10,8,2])) # may return [10,10,2,2] on naive solutions.
  end

  def test_backtrack    
    assert_equal([99,99,99], make_change(297, [100, 99, 1]))
    assert_equal([100,99,99,99], make_change(397, [100, 99, 1]))
    #assert_equal([100,100,99,99,99], make_change(497, [100, 99, 1]))
  end
  
  def test_time
     assert_equal([1000000, 1], make_change(1000001, [1000000, 1]))
    # AND complete in a reasonable time (avoid brute force searches)    
  end
end