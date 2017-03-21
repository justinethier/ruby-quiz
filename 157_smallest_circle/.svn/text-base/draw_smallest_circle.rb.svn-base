# Justin Ethier
# Graphics portion of Solution to ruby quiz 157
require 'smallest_circle.rb'
require 'RMagick'
include Magick

class SmallestCircleGraphics
  def initialize
    @width = 800
    @height = 800
    @small_circle_radii = 16
  end
  def draw(circle, points, filename)
    canvas = Magick::ImageList.new
    canvas.new_image(
      @width,
      @height,
      Magick::HatchFill.new('white', 'white'))

    do_draw(circle, points, canvas)
    
    # Write to file
    canvas.write(filename)  
  end
  
  # Do the actual drawing
  def do_draw(circle, points, canvas)
    draw = Magick::Draw.new

    draw.fill('light gray')
    draw.ellipse(scale(circle.center.x), 
                 scale(circle.center.y), 
                 circle.radius * @height/2, 
                 circle.radius * @height/2, 
                 0, 360)

    draw.fill('red')
    draw.fill_opacity('65%')
    for pt in points
      draw.ellipse(scale(pt.x), 
                   scale(pt.y), 
                   @small_circle_radii, @small_circle_radii, 0, 360)
    end
    draw.draw(canvas)
  end
  
  # Scale a value to fit on the canvas
  def scale(value)
    value * @height/2 + @height/4
  end
  
  private :do_draw, :scale
end


if ARGV.size == 2
  points = generate_samples(ARGV[0].to_i)
  gfx = SmallestCircleGraphics.new
  circle = encircle(points)
  gfx.draw(circle, points, ARGV[1])
else
  puts "Usage: draw_smallest_circle.rb num_circles output_filename"
end
