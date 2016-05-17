#30506
filterTaps <- c(0.002385,
0.011910,
0.026352,
0.039825,
0.045351,
0.039825,
0.026352,
0.011910,
0.002385)

filterTaps2 <- filterTaps / sum(filterTaps)

freqz(filterTaps)


freqz(filterTaps2)

getNumSamples <- 1000

reader <- rnorm(getNumSamples,0,1)
writeback <- 0*reader

delayLine <- 0*filterTaps
result <- 0; # initialisation to 0 of the result
for (sample in seq(1,getNumSamples)) 
{ # for each sample
    
    # moving the samples in the delay line
    for (i in seq(8,1,-1)) 
    { # delayLine being 9 values long
        delayLine[i + 1] = delayLine[i];
    }
    delayLine[1] = reader[sample];
    
    result = 0;
    for (i in seq(1,9)) 
    { # for each tap
          result = result + delayLine[i] * filterTaps[i]; # multiply     
    }
    writeback[sample] <- result; # output
}
