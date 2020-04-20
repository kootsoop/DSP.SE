# 30067

prototype_length <- 40

A <- rep(0, prototype_length)
A[(prototype_length/4+1):(3*prototype_length/4)] <- sin(2*pi*seq(0,prototype_length/2-1)/prototype_length)


B <- rep(0, prototype_length)
B[(prototype_length/4+1):(3*prototype_length/4)] <- `^`(sin(2*pi*seq(0,prototype_length/2-1)/prototype_length),12)*3/8

plot(A, type="l", col="blue", lwd=5)
lines(B, col="red", lwd=5)
title('Centered Signals')

data_length <- 400

data <- rep(0, data_length)

place_A <- floor(runif(1, prototype_length, data_length - prototype_length))
place_B <- floor(runif(1, prototype_length, data_length - prototype_length))


data[place_A + c(1:prototype_length)] <- A
data[place_B + c(1:prototype_length)] <- B

data <- data + rnorm(length(data), 0, 0.05)

par(mfrow = c(3,1))
plot(data, type="l")


remove_one <- function(to_remove, data_in, place_in) 
{  
  check_A <- conv(to_remove,data_in)
  i_max_A <- which.max(check_A) - prototype_length - 1  # Correct for convolution length N+M-1
  
  data_out <- data_in
  data_out[i_max_A+c(1:prototype_length)  ] <- data_out[i_max_A+c(1:prototype_length) ] - to_remove
  
  plot(data_in, ylim=c(-1,1))
  points(c(place_in,place_in,place_in),c(0,0.5,1),col="green", lwd=5)
  lines(c(i_max_A,i_max_A),c(0,1),col="red")
  lines(data_out)
  
  print(i_max_A)

  return(data_out)
}

data2 <- remove_one(A, data, place_A)

data3 <- remove_one(B,data2, place_B)
