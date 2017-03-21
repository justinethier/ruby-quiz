# edit_test.rb
# usage: ruby -r klass.rb edit_test.rb <iter> \
# [<constructor> [<lines> <columns>] ...]

require 'benchmark'
require 'test/unit/assertions'
include Test::Unit::Assertions

# char = byte pre 1.9, each_char already defined in 1.9
unless "".respond_to?(:each_char)
  class String;alias_method(:each_char, :each_byte);end
end

iterations = 10 #ARGV.shift.to_i

while cursor = ARGV.shift
  nlines = (ARGV.shift || 10000).to_i
  ncolumns = (ARGV.shift || 100).to_i
  n = nlines*ncolumns
  chars = (?a..?z).to_a
  line = (0...ncolumns).inject("") { |line, i|
    line << chars[i%chars.length]
}
line[-1] = ?\n

iterations.times { eval(cursor).instance_eval {
      Benchmark.benchmark(
        "#{cursor}: #{nlines}x#{ncolumns}\n",16,nil,"total"
      ) { |b|
        
        total = b.report("insert_before") {
          nlines.times { line.each_char { |ch| insert_before(ch) } }
        }
        i = 0
        total += b.report("left") { i += 1 while left }
        assert_equal(n, i)
        i = 0
        total += b.report("right") { i += 1 while right }
        assert_equal(n, i)
        i = 0
        total += b.report("up") { i += 1 while up }
        assert_equal(nlines, i)
        i = 0
        total += b.report("down") { i += 1 while down }
        assert_equal(nlines, i)
        total += b.report("insert_after") {
          nlines.times { line.each_char { |ch| insert_after(ch) } }
        }
        i = 0
        total += b.report("delete_before") {
          i += 1 while delete_before
        }
        assert_equal(n, i)
        i = 0
        total += b.report("delete_after") {
          i += 1 while delete_after
        }
        assert_equal(n, i)
        
        [total]
        
      }
    } }
end