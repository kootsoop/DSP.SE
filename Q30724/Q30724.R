#30724

fs <- 500000000
N <- 14000000

frequencies <- c(138, 50, 190, 86, 172, 224) * 1000000

print(frequencies * N / fs)
