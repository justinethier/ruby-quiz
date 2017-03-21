# Justin Ethier
# Solution to ruby quiz 157

class Point < Struct.new(:x, :y)
    def self.random
        Point.new(rand, rand)
    end

    def to_s
        "(#{x}, #{y})"
    end
end

class Circle < Struct.new(:center, :radius)
    def to_s
        "{center:#{center}, radius:#{radius}}"
    end
end

# Calculate distance between points
def distance(pt_a, pt_b)
  Math.sqrt((pt_a.x - pt_b.x) * (pt_a.x - pt_b.x) + 
            (pt_a.y - pt_b.y) * (pt_a.y - pt_b.y))
end

# Determine if given points are all within a circle
def inside_circle?(points, circle)
  for point in points
    dist = distance(point, circle.center)
    return false if dist > circle.radius
  end
  true
end

def encircle(points)        # takes array of Point objects
  # find the average midpoint of all points
  mid = Point.new(
    points.inject(0){|sum, pt| sum += pt.x} / (points.size * 1.0),
    points.inject(0){|sum, pt| sum += pt.y} / (points.size * 1.0))

  # sort points by longest distance from midpoint
  # longest point (index 0) is the initial radius
  points.sort!{|a,b| distance(mid, a) <=> distance(mid, b) }.reverse!

  # Taking the average midpoint does not necessarily work because the points may
  # be weighted more heavily to one side. We correct for this by sliding the circle
  # along the line from its original center to the outmost point, decreasing the
  # radius as we go. Keep doing this until the circle can be made no smaller.
  point = points[0]
  slope = (mid.y - point.y) / (mid.x - point.x)
  new_pt, delta, sign = mid, 0.0, 1.0
  sign = -1.0 if mid.x > point.x
  while inside_circle?(points, Circle.new(new_pt, distance(new_pt, point)))
    mid = new_pt
    delta += 0.000001 * sign
    new_pt = Point.new(mid.x + delta, mid.y + (slope * (delta)))
  end
  
  return Circle.new(mid, distance(mid, point))
end
  
def generate_samples(n)
    (1..n).map { Point.random }
end
