/*
ellipse(
(21.0+25.0+30.0)/3.0,
(21.0+26.0+13.0)/3,
10,
10);
*/
//fill(red);

float []x = {21.0, 52.0};
float []y = {21.0 , 52.0};

// find the midpoint of all points
float []mid = {0,0};
for (int i = 0; i < x.length; i++)
{
  mid[0] += x[i];
  mid[1] += y[i];
}
mid[0] /= x.length;
mid[1] /= y.length;
print( "x:" + mid[0] + " y: " + mid[1]);

// find longest distance from midpoint to any of the points
float longest_dist = 0.0;
for (int i = 0; i < x.length; i++)
{
  float cur_dist = sqrt((mid[0]-x[i]) * (mid[0]-x[i]) + 
                        (mid[1]-y[i]) * (mid[1]-y[i]));
  print("\n" + cur_dist);
  if (cur_dist > longest_dist)
  {
    longest_dist = cur_dist;
  }
}

// Draw everything
ellipse(mid[0], mid[1],longest_dist*2, longest_dist*2);

for (int i = 0; i < x.length; i++)
{
  point(x[i], y[i]);
}

stroke(255,0,0);
point(mid[0], mid[1]);
