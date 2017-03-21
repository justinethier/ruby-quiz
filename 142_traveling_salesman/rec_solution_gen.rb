require 'grid.rb'

class TravelingSalesmanRecursiveSolver
  def solve(grid)
    # pick a starting point
    start_pt = [rand(grid.n), rand(grid.n)]
    path = [start_pt] #[]
    pts_travelled_to = (0...grid.n).map{|i| []} # Use a grid bitmask for fast lookup (nil ==> not visited yet)
    pts_travelled_to[start_pt[X]][start_pt[Y]] = 1
    
    puts "Start at #{start_pt[X]}, #{start_pt[Y]}"
    solved = rec_solve(grid, start_pt, start_pt, path, pts_travelled_to)
    return solved, path
  end
  
  def rec_solve(grid, start_pt, current_pt, path, pts_travelled_to)
    # for each adjacent point
    for pt in find_adjacent_pts(grid, current_pt)
      # have all points been travelled to, and is last pt the start_pt?
      if visited_all_pts?(grid, pts_travelled_to) and 
         start_pt[X] == pt[X] and start_pt[Y] == pt[Y] 
        # Yes, found a solution
        add(pt, path, pts_travelled_to)
        return true
      
      # if not travelled to, add to points_travelled_to
      elsif pts_travelled_to[pt[X]][pt[Y]] == nil
        add(pt, path, pts_travelled_to)

        # Keep going
        solved = rec_solve(grid, start_pt, pt, path, pts_travelled_to)

        if solved
          return solved
        else
          # If we got here and no solution (not solved), remove last point from points_travelled_to
          remove(pt, path, pts_travelled_to)
        end         
      end
    end
    
    # No solution here, back up
    return false 
  end
  
  def add(pt, path, pts_travelled_to)
    path.push(pt)
    pts_travelled_to[pt[X]][pt[Y]] = 1
    puts "Traveling to #{pt[X]}, #{pt[Y]}"
  end
  
  def remove(pt, path, pts_travelled_to)
    path.pop
    pts_travelled_to[pt[X]][pt[Y]] = nil
    puts "Backtracking from #{pt[X]}, #{pt[Y]}"
  end
  
  def visited_all_pts?(grid, pts_travelled_to)
    pts = pts_travelled_to.flatten
    
    (pts.size == (grid.n * grid.n)) and (pts.index(nil) == nil)
  end
  
  # Return a list of adjacent points given a single pt (x, y)
  def find_adjacent_pts(grid, pt)
    pts = []
    for x in [pt[X] - 1, pt[X], pt[X] + 1]
      for y in [pt[Y] - 1, pt[Y], pt[Y] + 1]
        pts << [x, y] unless x < 0 or y < 0 or 
                             x == grid.n or y == grid.n or
                            (x == pt[X] and y == pt[Y])
      end
    end
    
    pts
  end
end

# TODO: Test cases
t = TravelingSalesmanRecursiveSolver.new
#arry = t.find_adjacent_pts([2, 3])
#arry = t.find_adjacent_pts([0, 3])
visited = t.visited_all_pts?(Grid.new(2), [[1, 1],[1]])

#for n in 2..7
n = 3
  puts "n = #{n}"
  solved, solution = t.solve(Grid.new(n))
  puts "Solved = #{solved}"
for pt in solution
  puts "Move to #{pt[X]}, #{pt[Y]}"
end
arry = nil
