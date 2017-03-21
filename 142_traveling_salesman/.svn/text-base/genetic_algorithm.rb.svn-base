require 'grid.rb'

# Class to quickly find a (sub-optimal) solution
class TravelingSalesmanQuickSolver
  def solve(grid)
    path = [[0,0]] # pick a starting point

    if (grid.n % 2) == 0
      for x in 0..grid.n
        for y in 0..grid.n
        end
      end
    end

    return path
  end
end

t = TravelingSalesmanQuickSolver.new
path = t.solve(4)
for pt in path
  puts "Move to #{pt[X]}, #{pt[Y]}"
end

class GeneticAlgorithm
  # TODO: Runs the 5 steps described in problem description:
  def find_solution(n)
    grid = Grid.new(n)
    
    # Step 1. Generate a random initial population of itineraries.
    population = gen_random_population(grid.pts)
    
    # while not solved
    
      # Step 2. Replicate each itinerary with some variation.
      population = replicate(population)
      
      # Step 3. Rank the population according to a fitness function.
      population = rank(population)
      
      # Step 4. Reduce the population to a prescribed size,
      #         keeping only the best ranking itineraries.
      population = reduce(population) #, size)
      
      # Step 5. Go to step 2 unless best itinerary meets an exit criterion.
      # TODO: For now, use 5% criterion (IE: within 5% of min) but eventually take it from cmd line
    # end
  end
  
  # Step 1. Generate a random initial population of itineraries.
  # You can get the points you need to generate a new random itinerary 
  # by calling pts on an instance grid of the Grid class shown above.
  def gen_random_population(pts)
    return nil
  end

  # Step 2. Replicate each itinerary with some variation.
  # GAs apply what are called genetic operators to replicas of the 
  # population to produce variation. Genetic operators are usually 
  # referred to by biological sounding names such mutation, recombination, 
  # or crossover. Recombination means some kind of permutation. In my 
  # GA solution of the problem proposed here, I used two recombination 
  # operators, exchange and reverse. Exchange means cutting an itinerary 
  # at three points (yielding four fragments) and swapping the middle two 
  # fragments. Reverse means cutting an itinerary at two points (yielding 
  # three fragments) and reversing the order of the middle fragment.
  def replicate(population)
    #TODO: Need to figure out rules for modifying paths that will enable variations but at the
    # same time ensure that the solution is correct
    return nil
  end
  
  # Step 3. Rank the population according to a fitness function.
  # The fitness function for the traveling salesman problem can be the total 
  # distance traversed when following an itinerary (including the return to 
  # the starting point), or it can be a related function that reaches its 
  # minimum for exactly the same itineraries as does the total distance function.
  def rank(population)
    # TODO: Simply sort by the size of each population?
    return nil
  end

  # Step 4. Reduce the population to a prescribed size,
  #         keeping only the best ranking itineraries.
  def reduce(population)
    return nil
  end

end