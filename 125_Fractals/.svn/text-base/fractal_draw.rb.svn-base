=begin
Justin Ethier
May 2007
Solution to: http://www.rubyquiz.com/quiz125.html

This file contains the fractal drawing class. The purpose
of this class is to take a list of directions from the
FractalModel class and draw them.
=end

require 'RMagick'
include Magick

class FractalGfxDraw
  POINT_X = 0
  POINT_Y = 1
   
  # Draw the given list of fractal traces to file
  def draw(fractal_list, filename, width, height, start_x, start_y, color=nil)
    canvas = Magick::ImageList.new
    canvas.new_image(width, height, Magick::HatchFill.new('white', 'white'))

    # Draw the fractal
    fill_canvas(canvas, fractal_list, width, height, start_x, start_y, color)
    
    # Write to file
    canvas.write(filename)  
  end
  
  # Fill the given canvas with fractal traces
  def fill_canvas(canvas, fractal_list, width, height, start_x, start_y, color)
    # Change these points to define the place at which drawing begins
    cur_pt = [start_x, start_y] # x, y
    new_pt = [start_x, start_y] # x, y
    
    # Settings for lines of the fractal
    line_len = 8
    line = Magick::Draw.new
    line.stroke('green') #tomato')
    line.fill_opacity(0)
    line.stroke_opacity(0.75)
    line.stroke_width(2)

    # Draw the fractal line-by-line
    for i in 0..fractal_list.size
      
        dir = fractal_list[i]
        
        if (color != nil)
          line.stroke("rgb(0, " + color[i].to_s + ", 0)")
        end
        
        # Move the cursor
        if dir == 0
          new_pt[POINT_X] = new_pt[POINT_X] + line_len
        elsif dir == 90
          new_pt[POINT_Y] = new_pt[POINT_Y] + line_len
        elsif dir == 180
          new_pt[POINT_X] = new_pt[POINT_X] - line_len
        elsif dir == 270
          new_pt[POINT_Y] = new_pt[POINT_Y] - line_len
        end
        
        # Draw the line
        line.line(width - cur_pt[POINT_X], height - line_len - cur_pt[POINT_Y], 
                  width - new_pt[POINT_X], height - line_len - new_pt[POINT_Y])

        # Move cursor to the next point
        cur_pt[POINT_X] = new_pt[POINT_X]
        cur_pt[POINT_Y] = new_pt[POINT_Y]
    end
    
    # Draw all lines to canvas
    line.draw(canvas)
  end
end

