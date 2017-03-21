# Justin Ethier
# Ruby Quiz #128 - Verbal Arithmetic
# 
# At the outset, I had no idea how difficult this problem would be. In fact, it 
# turns out that this is actually an NP-complete problem if the number base is not
# fixed to 10. Anyway... Initially I experimented with a backtracking solution, but
# ran into trouble getting it to work properly. So for now I am submitting this
# solution. Although less than perfect, it does work for the test inputs, as well
# as additional solutions I have tried. The idea is to essentially brute force a 
# solution by trying all possible combinations of solutions until one works.

# Brute force approach to Verbal Arithmetic

# Permutation Gem
# See: http://permutation.rubyforge.org/doc/index.html
require 'Permutation'

# Combinations class from: http://butunclebob.com/ArticleS.UncleBob.RubyCombinations
# There should be a gem for this!!!
class Combinations
  def self.c(n,r,&proc)
    if (n>0 && r>0)
      combine([], 0, n, r, proc)
    end
  end

  def self.get(n,r) 
    combinations = []
    Combinations.c(n,r) {|c| combinations << c}
    combinations
  end

  private
  def self.combine(combination, s, n, r, proc)
    if (r == 0)
      proc.call(combination)
    else
      (s..(n-r)).each {|i| combine(combination + [i], i+1, n, r-1, proc)}
    end
  end
end


class VerbalArithmetic
  # Parse given equation into lvalues (words on the left-hand side of the '=' that
  # are to be added together) and an rvalue (the single word on the right-hand side)
  def parse_equation (equation)
    lvalues = equation.split("+")
    rvalue = lvalues[-1].split("=")
    lvalues[-1] = rvalue[0] # Get last lvalue
    rvalue = rvalue[1]      # Get rvalue
    
    return lvalues, rvalue
  end

  # Try all combinations solution  
  def find_solution(lvalues, rvalue)
    # Form a list of all letters 
    words = Marshal::load(Marshal::dump(lvalues))
    words.push(rvalue)
    letters = {}
    words.each do |word| 
      word.split("").each do |letter|
        letters[letter] = letter if letters[letter] == nil        
      end
    end
    
    # Format l/r values to ease solution analysis
    lvalues_formatted = []
    lvalues.each {|lval| lvalues_formatted.push(lval.reverse.split(""))}
    rvalue_formatted = rvalue.reverse.split("")    
    
    # For all unordered combinations of numbers...
    for i in Combinations.get(10, letters.values.size)
      # For all permutations of each combination...
      perm = Permutation.for(i)
      perm.each do |p|
      
        # Map each combination of numbers to the underlying letters
        map = {}
        parry = p.project
        for i in 0...letters.size
          map[letters.values[i]] = parry[i]
        end

        # Does this mapping yield a solution?
        if is_solution?(lvalues_formatted, rvalue_formatted, map)
          return map
        end
      end
    end
    
    nil
  end

  # Determines if the given equation may be solved by
  # substituting the given number for its letters
  def is_solution?(lvalues, rvalue, map)
    # Make sure there are no leading zero's
    for lval in lvalues
      return false if map[lval[-1]] == 0
    end
    return false if map[rvalue[-1]] == 0
 
    # Perform arithmetic using the mappings, and make sure they are valid
    remainder = 0
    for i in 0...rvalue.size
      lvalues.each do |lval|
        remainder = remainder + map[lval[i]] if map[lval[i]] != nil # Sum values
      end
      
      return false if (remainder % 10) != map[rvalue[i]] # Validate digit
      remainder = remainder / 10                         # Truncate value at this place
    end
    
    true
  end
end

va = VerbalArithmetic.new
lvalues, rvalue = va.parse_equation("forty+ten+ten=sixty") #"send+more=money") #
map = va.find_solution(lvalues, rvalue)  
puts "Solution: ", map if map != nil