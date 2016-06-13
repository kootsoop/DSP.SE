# 31483

T <- 1000
t <- (0:(T-1))-(T-1)/2
gaus <- exp(-(t/200)^2)
gaus <- gaus/gaus[1]

N <- ceiling(max(gaus))
left <- round(gaus)
start_idx <- 1
length <- T

vals <- rep(0,N)

for (n in 1:N)
{
  vals[n] <- start_idx
  new_filter <- c(rep(0,start_idx-1), rep(1,length), rep(0,start_idx-1))
  left <- left - new_filter
  start_idx <- NA
  check_num <-1
  while ((is.na(start_idx)) && (sum(left) > 0))
  {
    start_idx <- min(match(check_num,left))
    print(start_idx)    
    check_num <- check_num + 1
  }
  length <- T - 2*start_idx + 2
  if (sum(left) == 0)
  {
    break
  }
}

plot(gaus-round(gaus), type="l", col="blue")
title("Error between unity gain filter approximation and gaussian filter")
