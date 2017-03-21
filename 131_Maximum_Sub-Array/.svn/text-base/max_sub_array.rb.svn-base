=begin
Justin Ethier
July 2007

Solution for Ruby Quiz #131 - Max Sub-Array
See: http://www.rubyquiz.com/quiz131.html
=end

# Object defining a sub-array of integer values
# The sub-array contains a start and end index 
# defining a region of the master array
class SubArray
  def initialize
    @start = 0
    @end = 0
  end
  
  # Set boundaries of the sub-array
  def set_bounds(list_start, list_end)
    @start, @end = list_start, list_end
  end
  
  # Calculate sum of integers in the sub-array,
  # give the master array (list)
  def sum(list)
    sum = 0
    for num in list.slice(@start, @end - @start + 1)
        sum = sum + num
    end
    
    sum
  end
  
  # Provide read access to indexes
  attr_reader :start, :end
end

# Methods to find a sub-array with the maximum sum
class MaxSubArray

  # Return the sign of a number
  def sign(num)
    if num < 0
      return -1
    end
    
    return 1
  end
  
  # Find the running sum of all numbers of the same sign as the start index
  # Returns: 
  #   Sum
  #   Ending Index (First index of a number with a different sign)
  def find_running_sum(list, start)
    sum = 0
    i = start
    
    while i < list.size and (sign(list[i]) == sign(list[start]))
      sum = sum + list[i]
      i = i + 1
    end
    
    return sum, i
  end
  
  # Finds the maximum sub array of a list of integers
  # 
  #  For example:
  #  -6, -19, 22, 18, 19, 22, -11, -3, 2, 21, 6, 10, 4, 
  #  
  #  May be thought of as collapsing down to:
  #  -25, 81, -14, 43, -23, 86, -65, 48
  #  
  # Keeping this in mind, you can find the sub-array by keeping this list unless the 
  # negative numbers bring a sum down below a value the positive numbers cannot bring 
  # it back to. In this case terminate the list at its maximum value.
  # 
  def find(list)
    max = SubArray.new
    cur = SubArray.new
    
    i = 0
    while i < list.size
      if list[i] < 0        
        neg_sum, i = find_running_sum(list, i) # Get sum of neg nums in run
        pos_start = i
        pos_sum, i = find_running_sum(list, i) # Get sum of pos nums in next run
        
        # If negative numbers outweigh positive ones, any possible subarray has ended. 
        # Or, if the running sum is negative, discard negative run.
        # In either case, start fresh at the front of the positive run of numbers.
        if (neg_sum + pos_sum < 0 or (cur.sum(list) < 0))
          cur.set_bounds(pos_start, i - 1)
        else
          # Else negative numbers do not have an impact, include both runs and keep going
          cur.set_bounds(cur.start, i - 1)
        end
      else
        # Start new subarray if current sum is neg and current number is pos
        if (list[i] > 0 and cur.sum(list) < 0)
          cur.set_bounds(i, i)
        else
          # Found a positive number, increment the current index
          cur.set_bounds(cur.start, i)
        end
        
        i = i + 1
      end
      
      # Set a new max, if needed
      if (cur.sum(list) > max.sum(list))
        max.set_bounds(cur.start, cur.end)
      end
      
    end
    
    list.slice(max.start, max.end - max.start + 1)
  end
end

