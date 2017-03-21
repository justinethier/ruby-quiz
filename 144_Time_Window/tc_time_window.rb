=begin
Justin Ethier
October 2007
Test Cases for Ruby Quiz 144 - Time Window
=end
require 'time_window.rb'

class TestTimeWindow < Test::Unit::TestCase
  def test_window_1
    w = TimeWindow.new("Sat-Sun; Mon Wed 0700-0900; Thu 0700-0900 1000-1200")
    
    assert ! w.include?(Time.mktime(2007,9,25,8,0,0)) # Tue
    assert w.include?(Time.mktime(2007,9,26,8,0,0)) # Wed
    assert ! w.include?(Time.mktime(2007,9,26,11,0,0))
    assert ! w.include?(Time.mktime(2007,9,27,6,59,59)) # Thu
    assert w.include?(Time.mktime(2007,9,27,7,0,0))
    assert w.include?(Time.mktime(2007,9,27,8,59,59))
    assert ! w.include?(Time.mktime(2007,9,27,9,0,0))
    assert w.include?(Time.mktime(2007,9,27,11,0,0))
    assert w.include?(Time.mktime(2007,9,29,11,0,0)) # Sat
    assert w.include?(Time.mktime(2007,9,29,0,0,0))
    assert w.include?(Time.mktime(2007,9,29,23,59,59))
  end

  def test_window_2
    w = TimeWindow.new("Fri-Mon")
    assert ! w.include?(Time.mktime(2007,9,27)) # Thu
    assert w.include?(Time.mktime(2007,9,28))
    assert w.include?(Time.mktime(2007,9,29))
    assert w.include?(Time.mktime(2007,9,30))
    assert w.include?(Time.mktime(2007,10,1))
    assert ! w.include?(Time.mktime(2007,10,2)) # Tue
  end

  def test_window_3
    w = TimeWindow.new("Fri Mon")
    assert ! w.include?(Time.mktime(2007,9,27)) # Thu
    assert   w.include?(Time.mktime(2007,9,28)) # Fri
    assert ! w.include?(Time.mktime(2007,9,29))
    assert ! w.include?(Time.mktime(2007,9,30))
    assert   w.include?(Time.mktime(2007,10,1)) # Mon
  end  
  
  def test_window_nil
    w = TimeWindow.new("")
    assert w.include?(Time.mktime(2007,9,25,1,2,3)) # all times
  end
end