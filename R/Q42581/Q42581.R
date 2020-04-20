# 42581
N <- 900

data <- runif(N)
data_convolved <- convolve(data, data)

data_sorted <- sort(data)
data_sorted_convolved <- convolve(data_sorted, data_sorted)

plot(data_convolved, type='l', col='blue', ylim=c(0,500))
lines(data_sorted_convolved, col='red')

kernel <- density(data, n=N)
lines(kernel$y*280)