#26630
Nsamples <- 100
T <- 1000
noise <- runif(T,-1,1)

additive <- rep(0,Nsamples)
multiplicative <- rep(0,Nsamples)

for (value in 1:Nsamples)
{  
  what_you_want_to_know <- value * rep(1,T)
  what_you_can_measure <-  what_you_want_to_know + noise
  what_you_can_measure_2 <-  sqrt(what_you_want_to_know) * noise
  
  additive[value] <- mean(what_you_can_measure)
  multiplicative[value] <- mean(what_you_can_measure_2*what_you_can_measure_2)
}


plot(1:Nsamples, additive)
plot(1:Nsamples, multiplicative)
