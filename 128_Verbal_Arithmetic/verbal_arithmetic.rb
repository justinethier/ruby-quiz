# Classic backtracking problem (??)

#To do base-x arithmetic:
# Get all words
# Divide each one into a list, setup an empty remainder list
# For all last elements of the list [-1], do arith
# Add remainders to remainder list (segment by 10's place)

#To do verbal arith:
# Assign a value to each number as you go (starting from 1)
# If down the road a number fails, then backtrack
# Rules for assigning numbers:
#  - Leading nums cannot be 0
#  - Cannot assign the same number to multiple letters
#  - Can only have up to 10 letters (0 - 9)

require 'Permutation'
#see: http://permutation.rubyforge.org/doc/index.html

# Modified Combinations class from: http://butunclebob.com/ArticleS.UncleBob.RubyCombinations
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
  def parse_equation (equation_str)
    #TODO: Regex to verify eq is properly formed
    
    lvalues_str = equation_str.split("+")
    rvalue_str = lvalues_str[-1].split("=")
    lvalues_str[-1] = rvalue_str[0]
    rvalue_str = rvalue_str[1]
    
    # used by backtracking only
    # Get character arrays, reverse them to make things easier to process
    #lvalues = []
    #lvalues_str.each {|lval| lvalues.push(lval.reverse.split(""))}
    #rvalue = rvalue_str.reverse.split("")
        
    return lvalues_str, rvalue_str
  end

  # Try all combinations solution  
  def brute_force(lvalues, rvalue)
    # get a list of all letters 
    words = Marshal::load(Marshal::dump(lvalues))
    words.push(rvalue)
    letters = {}
    words.each do |word| 
      word.split("").each do |letter|
        letters[letter] = letter if letters[letter] == nil        
      end
    end
    
    # For all combinations of numbers
    for i in Combinations.get(10, letters.values.size) #choose(10, 8).sort 
      # For all permutations
      perm = Permutation.for(i)
      perm.each do |p|
        map = {}
        parry = p.project
        for i in 0...letters.size
          map[letters.values[i]] = parry[i]
        end

#map = {"a"=>1, "c"=>2, "e"=>3}
#        puts map
        lvalues_p = []
        lvalues.each {|lval| lvalues_p.push(lval.reverse.split(""))}
        rvalue_p = rvalue.reverse.split("")
        if is_solution?(lvalues_p, rvalue_p, map)
          return map
        end
      end
    end
    
    nil
  end
  
  # Backtracking solution (incomplete)
  def calculate_nums (lvalues, rvalue, remainder=0, mappings = {}, place=0)
  
    # Get preliminary solution at this level
    prelim_mappings, remainder = calc_single_digit(lvalues, rvalue, remainder, mappings, place)
    
    # If a solution was found, Get mappings at this level, and store for later
    if (prelim_mappings != nil)
      # Found last solution, return everything
      if (place == rvalue.size-1)
        return prelim_mappings
      else
        # Save first mappings calculated at this place to determine when we need to backtrack
        first_mappings = {}
        lvalues.each { |lval| first_mappings[lval[place]] = prelim_mappings[lval[place]] }
        first_mappings[rvalue[place]] = prelim_mappings[rvalue[place]] 
        
        loop do 
          # Calculate mappings for rest of the places
          prelim_mappings = calculate_nums(lvalues, rvalue, remainder, prelim_mappings, place + 1)
          
          if (prelim_mappings == nil)
            # Recalculate mappings at this place
            # 
            # !!!!!!!!!!!!!!!!!!!!
            # TODO: Need to consider cases where a computed mapping needs to change.
            #  in this case, a mapping will need to be chosen to change and the code will need to
            #  back up to the first place that uses the mapping, since changing it will invalidate all
            #  previous calculations that used it.
            # !!!!!!!!!!!!!!!!!!!!
            # 
            prelim_mappings, remainder = calc_single_digit(lvalues, rvalue, remainder, mappings, place)
          else
            # A solution has been found, return it
            return prelim_mappings
          end
          
          break if (prelim_mappings == nil or hash_contains?(prelim_mappings, first_mappings))
        end
      end
    end
    
    return nil    
  end
  
  def hash_contains?(superset, subset)
    subset.each_key do |key|
      return false if (superset[key] != subset[key])
    end
    
    true
  end
  
  # Do arithmetic for one column of digits (EG: 10's place)
  # Adjusts mappings accordingly
  # Inputs: lvalues
  #         rvalues
  #         remainder - Remainder from previous place calculations. Integer
  #         mappings - Current letter==>digit mappings
  # Output: Returns new remainder if this column was resolved, nil if not
  def calc_single_digit(lvalues, rvalue, remainder, existing_mappings, place)
    # Convert to single char arrays
    lvals = []
    lvalues.each {|lval| lvals.push(lval[place])}
    rval = rvalue[place]
    
    # Create a copy of the mappings to use at this level
    mappings = Marshal::load(Marshal::dump(existing_mappings))
    
    # Remove any nulls from lvalue list
    lvals.delete(nil)
    
    for i in 0...10 # Try 10 times (could be smarter, but who cares for now)
      sum = remainder
      lvals.each do |lval|
        # Get a new mapping for this letter, if one does not exist
        if not existing_mappings.has_key?(lval)
          mappings[lval] = get_next_digit(mappings, mappings[lval])
          
          # Could not assign a mapping for a letter, need to bail
          if mappings[lval] == nil          
            return nil, nil
          end
        end

        sum = sum + mappings[lval]
      end
      
      value = sum % 10
      if not existing_mappings.has_key?(rval) and not mappings.has_value?(value)
        mappings[rval] = value
        
        # Return new mappings and the remainder
        return mappings, sum / 10
      end
    end
    
    # No possible solution for this column
    return nil, nil
  end
  
  # Get the next available digit==>letter mapping
  # Optionally takes the current value of the mapping for this letter and increments it
  # TODO: Could clean up to just take an optional letter
  def get_next_digit(mappings, current_value = 0)
    current_value = 0 if (current_value == nil)
    
    for i in 0...10
      value = (i + current_value) % 10
      return value if (not mappings.has_value?(value))
    end
    
    return nil
  end
  
  # Determines if the given equation may be solved by
  # substituting the given number for its letters
  def is_solution?(lvalues, rvalue, map)
    # TODO: Could verify numbers/letters in map
    
    # Make sure there are no leading zero's
    for lval in lvalues
      return false if map[lval[-1]] == 0
    end
    return false if map[rvalue[-1]] == 0
 
    # Perform arithmetic using the mappings, and make sure they are valid
    remainder = 0
    for i in 0...rvalue.size
      lvalues.each do |lval|
        remainder = remainder + map[lval[i]] if map[lval[i]] != nil
      end
      
      return false if (remainder % 10) != map[rvalue[i]] # Validate digit
      remainder = remainder / 10                         # Truncate value at this place
    end
    
    true
  end
end

va = VerbalArithmetic.new
lvalues, rvalue = va.parse_equation("send+more=money")
map = va.brute_force(lvalues, rvalue)  
puts "Solution:"
puts map if map != nil