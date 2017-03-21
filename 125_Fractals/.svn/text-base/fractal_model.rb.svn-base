=begin
Justin Ethier
May 2007
Solution to: http://www.rubyquiz.com/quiz125.html

This file contains the fractal model class. The basic idea is that 
it will create a list of values corresponding to the direction of
the next line of the fractal. There are 4 possible directions (angles):

 |        090
- -   180     000
 |        270

And, for example, here are some possible lists:
 
000 090 000 270 000 (RURDR, no rotation)
090 180 090 000 090 (ULURU, 90 degree rotation, x = (x + 90) % 360)
270 000 270 180 270 (DRDLD, -90 degree rotation, x = (x - 90) % 360)

With this list, a program can draw the fractal by simply following
these traces, just like drawing without lifting your pen from the paper.
=end

require 'fractal_draw.rb'

class FractalModel

  def initialize()
    # This defines the overall shape of the fractal (at level 1)
    # TODO: check into SVN, then play around w/fractal commented-out below
    #@base_fractal = [90, 0, 90, 180, 0]
    @base_fractal = [0, 90, 0, 270, 0] #original one from 125
    #@base_fractal = [270, 180] #, 90, 180, 90, 0, 90, 90, 180, 270, 0, 0, 90, 0, 90, 180]
  end

  # Build a list of lines to trace for the fractal, 
  # based on the given depth level
  def build(level)
    # Build list of lines to draw
    # First level is base fractal, no offset rotation
    fractal_list = []
    rec_build(level, @base_fractal[0], 0, fractal_list)
    
    return fractal_list
  end
  
  # Recursively build the fractal
  # 
  #  level - Depth to build, 0 is lowest
  #  direction - Direction to draw the line, in 90-degree increments
  #  rotation - Rotational offset for the direction
  #  fractal_list - List to append fractal definition to
  #  
  def rec_build(level, direction, rotation, fractal_list)
    # At the lowest level, add an actual piece to the array
    if (level == 0)
      fractal_list.push((direction + rotation) % 360)
      return
    end
    
    # At higher levels, we need to define the shape of the fractal
    for piece_direction in @base_fractal
      rec_build(
        level - 1,        # Drill down to the next level
        piece_direction,  # Take direction from the base array
        (direction + rotation) % 360, # Rotate lower-level according to higher level structure
        fractal_list) # Append to the list
    end
  end
end

fract = FractalModel.new
gfx = FractalGfxDraw.new

# Get level from the CMD line
level    = ARGV[0] != nil ? ARGV[0].to_i : 3 # Default
filename = ARGV[1] != nil ? ARGV[1] : "output.jpg"

# Build fractal
list = fract.build(level)

# Render the fractal to file
width  = 8 * (3 ** level) # Rough approximation
height = 5 * (3 ** level) # Rough approximation
gfx.draw(list, filename, width, height, 0, 0)