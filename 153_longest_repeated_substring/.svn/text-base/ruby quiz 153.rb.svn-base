# Find first non-overlapping repeated substring contained in the input string.
# Search space is smaller for longer substrings, so search for longest ones first.
# Returns - Longest repeated substring, or nil if none
def longest_repeated_substring(input)
  len = input.size / 2 # Max size is half total length, since strings cannot overlap
  len = 255 if len > 255
  while len > 0
    # Find all substrings of given length
    sub_strings = {}
    for i in 0...input.size-len
      sub_str = input[i..i+len]
      
      if not sub_strings.has_key?(sub_str)
        # Add to list, track end pos for overlaps
        sub_strings[sub_str] = i+len 
      elsif sub_strings[sub_str] < i
        # First non-overlapping match ties for longest
        return sub_str 
      end
    end
    
    len -= 1
  end
  
  nil
end

# TODO: Benchmark

=begin
input = "
A Hash is a collection of key-value pairs. It is similar to an Array, except that indexing is done via arbitrary keys of any object type, not an integer index. The order in which you traverse a hash by either key or value may seem arbitrary, and will generally not be in the insertion order. 

Hashes have a default value that is returned when accessing keys that do not exist in the hash. By default, that value is nil. 

Hash uses key.eql? to test keys for equality. If you need to use instances of your own classes as keys in a Hash, it is recommended that you define both the eql? and hash methods. The hash method must have the property that a.eql?(b) implies a.hash == b.hash. 
"
input = "banana"
=end

from_file = false
input = ""
ARGV.each do |arg|
  case arg
    when /^-+f/
      from_file = true
    else
      input = arg
  end
end

if from_file
  fp = File.new(input, "rb") #homer-illiad.txt
  input = fp.read
end

puts longest_repeated_substring(input)
