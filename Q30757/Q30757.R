# 30757

denominator <- function(k) 
{
  return(c(1, (k-40), 400 - 4*k, 4*k))
}

k_values <- seq(0,10,0.001)

roots <- array(0, c(length(k_values),3))

for (k in k_values)
{
  roots[k,] <- polyroot(denominator(k))
}