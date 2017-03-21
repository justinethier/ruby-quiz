require 'RMagick'
require 'enumerator'
require 'grid.rb'

SPACING = 50
BORDER = 20
def draw_itin(itin, filename)
 dim = ($grid.n-1)*SPACING + BORDER * 2
 canvas = Magick::Image.new(dim, dim)
 gc = Magick::Draw.new
 gc.stroke('black')
 gc.stroke_width(1)

 $grid.pts.each do |(x,y)|
   gc.circle(*[x,y,x+3.0/SPACING, y].map{|c|c*SPACING+BORDER})
 end
 (itin+[itin.first]).each_cons(2) do |((x1,y1),(x2,y2))|
   gc.line(*[x1,y1,x2,y2].map{|c|c*SPACING+BORDER})
 end
 gc.draw(canvas)
 canvas.write(filename)
end

#n = 4 #ARGV[0].to_i

def create_itin(n)
  itin = ([0]*n).zip((0...n).to_a)
  
  1.step(n-3, 2) do |x|
   itin += ([x]*(n-1)).zip((1...n).to_a.reverse)
   itin += ([x+1]*(n-1)).zip((1...n).to_a)
  end
  
  if n%2==0
   itin += ([n-1]*(n-1)).zip((0...n).to_a.reverse)
  else
   (n-1).step(2, -2) do |y|
     itin += [[n-2,y],[n-1,y],[n-1,y-1],[n-2,y-1]]
   end
  end
  
  itin += (0...n).to_a.reverse.zip([0]*n)
  itin
end

for n in 3...10
  $grid = Grid.new(n) #Because draw_itin asks for it
  itin = create_itin(n)
  draw_itin(itin, "#{n}x#{n}tour2.jpg")
end
