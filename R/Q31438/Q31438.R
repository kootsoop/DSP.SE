#31438

#install.packages("quantmod")
require(signal)
require(quantmod)
T <- 100
filt <- butter(5,0.1)
red_line <- filter(filt, rnorm(T, 0, 1))

peaks <- findPeaks(red_line)
valleys <- findValleys(red_line)

plot(as.numeric(red_line), col="red", type="l")
points(peaks + 1, red_line[peaks], col="red")
points(valleys + 1, red_line[valleys], col="red", lwd = 3)


peak_idx <- 1
valley_idx <- 1
counter <- 1

values <- array(0, c(2,T))

while ( (peak_idx <= length(peaks)) && (valley_idx <= length(valleys)))
{
  mid_idx <- floor((peaks[peak_idx] + valleys[valley_idx]) / 2 )
  mid_value <- (red_line[peaks[peak_idx]] + red_line[valleys[valley_idx]])/2
  points(mid_idx, mid_value, col="orange", lwd = 5)
  
  values[1,counter] <- mid_idx
  values[2,counter] <- mid_value
  counter <- counter + 1
  
  if (valleys[valley_idx] > peaks[peak_idx])
  {
    peak_idx <- peak_idx + 1
  }
  else
  {
    valley_idx <- valley_idx + 1
  }
}

values[1,counter] <- T
values[2,counter] <- red_line[T]

interpolated <- spline(values[1,], values[2,], n=T)
lines(interpolated, col="blue")


