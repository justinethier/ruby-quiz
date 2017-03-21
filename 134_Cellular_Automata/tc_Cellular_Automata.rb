# Justin Ethier
# 
# Unit Tests and Test Code for:
# Ruby Quiz 134
# http://www.rubyquiz.com/quiz134.html
# 
$:.unshift File.join(File.dirname(__FILE__), "..")
require 'test/unit'
require 'Cellular_Automata.rb'

class TestCellularAutomata< Test::Unit::TestCase
  def setup
    @cell = CellularAutomata.new
  end
   
  def test_todo
    print "\nTest TODO\n"
    print @cell.convert_to_dec([1,1,1], 2)
    print @cell.convert_to_dec([1,0,1], 2)
    print "\n"
    print @cell.strip_value([0, 0, 1, 0, 0], 0)
    print "\n"
    print @cell.strip_value([0, 0, 1], 0)
    print "\n"
    print @cell.strip_value([1, 0, 0, 1], 0)
    print "\n"
    #print @cell.build_rule_array(30)
    print "\n"
    print @cell.compute_generation(@cell.strip_value([1,1,0,0,1], 0), 30)
    print "\n/Test TODO\n"
  end
  
  def test_run
    #TODO: how to support width w/out being a cmd line arg? may need to come up w/offset solution
    @cell.run(1, 1, [1])
    @cell.run(30, 10, [1])
    print "\n"
    #@cell.run(110, 20, [1])
  end
end
