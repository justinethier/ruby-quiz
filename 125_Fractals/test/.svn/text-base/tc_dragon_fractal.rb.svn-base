=begin
Justin Ethier
June 2007
=end

$:.unshift File.join(File.dirname(__FILE__), "..")
require 'test/unit'
require 'dragon.rb'

class TestFractalDragon < Test::Unit::TestCase
  
  def setup
    @fract = FractalDragon.new
  end

  def test_build_01
    list = @fract.build(1)
    assert_equal([270], list)
  end

  def test_build_02
    list = @fract.build(2)
    
    assert_equal([270, 180], list)
  end
  
  def test_build_03
    list = @fract.build(3)
    
    assert_equal([270, 180, 90, 180], list)
  end  
end
