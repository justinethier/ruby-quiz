$:.unshift File.join(File.dirname(__FILE__), "..")
require 'test/unit'
require 'verbal_arithmetic.rb'

class TestVerbalArithmetic < Test::Unit::TestCase
  def setup
  	@va = VerbalArithmetic.new
  end
  
  # Test Case: Parsing of multiple equations
  def test_parse_eq
    lvals, rval = @va.parse_equation("a+b=c")
    assert_equal([["a"], ["b"]], lvals)
    assert_equal(["c"], rval)    
    
    lvals, rval = @va.parse_equation("send+more=money")
    assert_equal([["d", "n", "e", "s"], ["e", "r", "o", "m"]], lvals)
    assert_equal(["y", "e", "n", "o", "m"], rval)    
  end
  
  # Test Case: Validating a solution is correct
  def test_valid_solution
    eq = "a+b=c"
    lvalues_str, rvalue_str = @va.parse_equation(eq)
    map = {"a"=>1, "b"=>2, "c"=>3}
    assert_equal(true, @va.is_solution?(lvalues_str, rvalue_str, map))
    map["c"] = 4
    assert_equal(false, @va.is_solution?(lvalues_str, rvalue_str, map))
    
    eq = "send+more=money"
    lvalues_str, rvalue_str = @va.parse_equation(eq)
    map = {
      "s"=> 9,
      "e"=> 5,
      "n"=> 6,
      "d"=> 7,
      "m"=> 1,
      "o"=> 0,
      "r"=> 8,
      "y"=> 2}
    assert_equal(true, @va.is_solution?(lvalues_str, rvalue_str, map))      
    map["y"] = 10
    assert_equal(false, @va.is_solution?(lvalues_str, rvalue_str, map))   
  end
  
  def test_get_next_digit
    map = {}
    map["a"] = 1
    assert_equal(0, @va.get_next_digit(map))
    
    map["b"] = 0
    map["c"] = 3
    assert_equal(2, @va.get_next_digit(map))    
  end
    
  def test_brute_force
    lvalues, rvalue = @va.parse_equation("ab+cd=ef")
    @va.brute_force(lvalues, rvalue)  
  end
  
  def test_calculated_nums
    lvals, rval = @va.parse_equation("ab+cd=ef")
    mappings = @va.calculate_nums(lvals, rval)
    assert_equal(true, @va.is_solution?(lvals, rval, mappings))
    
    lvals, rval = @va.parse_equation("send+more=money")
    mappings = @va.calculate_nums(lvals, rval)
    assert_equal(true, @va.is_solution?(lvals, rval, mappings))
  end
  
  def test_calc_single_digit
    #one+two=four
    map = {}
    map, remainder = @va.calc_single_digit(["eno", "owt"], "ruof", 0, map, 0)
    assert_equal(0, remainder)
    
    map, remainder = @va.calc_single_digit(["eno", "owt"], "ruof", 0, map, 1)
    assert_equal(1, remainder)
    
    map, remainder =  @va.calc_single_digit(["eno", "owt"], "ruof", 0, map, 2)
    assert_equal(nil, remainder)
    
    #map, remainder = @va.calc_single_digit([], 'f', remainder, map)
    #assert_equal(0, remainder)        
  end
end