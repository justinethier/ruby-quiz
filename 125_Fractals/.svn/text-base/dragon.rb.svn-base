require 'fractal_draw.rb'

class FractalDragon

  #def initialize
    # This defines the overall shape of the fractal (at level 1)
    #@base_fractal = [270]
  #end

  # Build a list of lines to trace for the fractal, 
  # based on the given depth level
  def build(level)
    fractal_list = [270]
    color = [255]

    for i in 1...level
      new_list = []
      for dir in fractal_list
        new_list.push((dir - 90) % 360)
        color.push(10 * i)
      end
      
      fractal_list = [fractal_list, new_list.reverse].flatten
    end
    
    return fractal_list, color
  end
  
end

fract = FractalDragon.new
gfx = FractalGfxDraw.new

# Get level from the CMD line
#level    = ARGV[0] != nil ? ARGV[0].to_i : 8 # Default
#filename = ARGV[1] != nil ? ARGV[1] : "output.jpg"

for level in 1...18
  print "Building dragon level " + level.to_s + "\n"
  
  # Build fractal
  list, color = fract.build(level)
  
  # Render the fractal to file
  width  = 2048 * 2 #8 * (3 ** level) # Rough approximation
  height = 1536 * 2 #5 * (3 ** level) # Rough approximation
  gfx.draw(list, "dragon_" + level.to_s + ".jpg", width, height, 1024*2, 768*2, color)
end
