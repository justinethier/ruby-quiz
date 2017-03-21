# Justin Ethier
# August 2007
# 
# Solution to Ruby Quiz #134
# 
# Quiz Description: http://www.rubyquiz.com/quiz134.html
# Background information: http://mathworld.wolfram.com/ElementaryCellularAutomaton.html
# 

class CellularAutomata
 
  # Compute a single iteration (Generation) of the cellular automata
  #  Inputs: State array, rule array
  # Returns: New State array
  def compute_generation(state, rule)
    result = Array.new

    # Pad front and back of state to compute boundaries
    state.insert(0,state[0]).flatten!
    state.push(state[-1])
    
    # Find the 3 digit binary num at each index, and build a list of the corresponding bits
    # Uses built-in ruby functionality to index individual bits
    (state.size - 2).times do |i|
      result.push(rule[convert_to_dec(state.slice(i, 3), 2)])
    end

    result
  end
  
  # Convert an array of numbers in the given base to a decimal number
  def convert_to_dec(num_array, base)
    result, place = 0, 0
    for digit in num_array.reverse
      result = result + digit * (base ** place)
      place = place + 1
    end
    result
  end
 
  # Run a series of generations
  def run(rule, steps, state)
     # Pad state to width of board
    (steps).times do
      state.insert(0, 0)
      state.push(0)
    end
 
    result = [].push(Array.new(state))
    
    steps.times do
      state = compute_generation(state, rule)
      result.push(Array.new(state))
    end
    
    result
  end

end

if ARGV.size == 3
  cell = CellularAutomata.new
  for generation in cell.run(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].split("").map{|i| i.to_i })
    print "\n", generation
  end
else
  print "Usage: Cellular_Automata.rb rule_number number_of_steps initial_state"
end

=begin
  # Obsolete code:
  
  
  # Strip (delete) a specific value from both ends of an array
  #  Inputs: Array to modify, value to remove
  # Returns: Updated array
  #def strip_value(array, value)
    #TODO: strip_value_at(array, 0,  0) # Leading 0's
    #TODO: strip_value_at(array, 0, -1) # Trailing 0's
  #  array
  #end
  
  # Private method to continuously remove a specific value at an array index
  #def strip_value_at(array, value, index)
  #  while (array[index] == value)
  #    array.delete_at(index)
  #  end
  #  
  #  array
  #end
  # Convert an integer rule to an 8-index array of 'bits' 
  # TODO: Obsolete, ruby can index a number via [] to get bits
  #def build_rule_array(rule_num)
  #  result = []
  #  sprintf("%08b", rule_num).split("").each{|i| result << i.to_i }
  #  result
  #end
=end