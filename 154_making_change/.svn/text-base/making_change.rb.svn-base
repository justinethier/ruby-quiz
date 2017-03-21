=begin
require 'gecoder'

class MakingChangeModel < Gecode::Model
  def initialize(amount)
    @set = set_var([], [25, 10, 5, 1])
    @set.sum == amount
    #branch_on @set, :variable => :smallest_size, :value => :min
  end
  
  def to_s
    @set.value.map{|i| i}
  end
end

# Print the solution.
puts MakingChangeModel.new(39).solve!.to_s
=end

class Array
  def sum
    cur_sum = 0
    self.each{|i| cur_sum += i}
    cur_sum
  end
end

def make_change(amount, coins = [25, 10, 5, 1])
  # TODO: sort coins?
  #change = []  
  #  
  #for i in 0...coins.size
  #  cur_change = rec_make_change(amount, coins.slice(i, coins.size), i, change)
  #  change = cur_change if (cur_change.size < change.size or change.size == 0) and
  #                         (cur_change.sum == amount)
  #end
  rec_make_change(amount, coins, [])
end

def is_solution?(amount, change)
  return (change != nil and change.sum == amount)
end

def rec_make_change(amount, coins, change)
  # amount still left?
  if is_solution?(amount, change)
    # No, we have a solution
    return change
  else
    i = 0
    best = []
    old_change = Array.new(change)
    for i in 0...coins.size      
      change = Array.new(old_change)
      
      while i < coins.size and change.sum < amount
        # yes, add
        if coins[i] <= (amount - change.sum)
          change << coins[i]
        else
          # try to add coin of next denomination
          change = rec_make_change(amount, coins.slice(i+1, coins.size), Array.new(change))
          i += 1
        end
        
        # do we have a solution?
        if is_solution?(amount, change)
          #return change
          best = Array.new(change) if (best.size == 0 or change.size < best.size)
        end
      end
    end
    
    return best
    # No solution found
    #nil
  end

end

#puts make_change(14, [10, 7, 1])