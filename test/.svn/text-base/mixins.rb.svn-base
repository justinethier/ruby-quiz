module Test
  def hello
    puts "hello test"
  end
end

module Test2
  def hello
    puts "hello test 2"
  end
end

class TestClass
  extend Test2
  extend Test
end

tc = TestClass.new
TestClass.hello