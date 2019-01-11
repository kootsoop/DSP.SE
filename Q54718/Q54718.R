gauspeak=function(x, u, w, h=1) h*exp(((x-u)^2)/(-2*(w^2)))

sumgauspeaks = function(x, u, w, h) {
  npeaks = length(u)
  n = length(x)
  Y_nonoise = do.call(cbind, lapply(1:npeaks, function (peak) gauspeak(x, u=u[peak], w=w[peak], h=h[peak]) ))
  y_nonoise = rowSums(Y_nonoise)
  set.seed(101)
  Y = apply(Y_nonoise, 2, function(col) rpois(n,col)) # peaks with Poisson noise
  y = rowSums(Y) # measured noisy signal (superposition of identical Gaussians of unknown width & width different heights)
  return(y)
}

# x = 1:1000
# npeaks = 40 # unknown number of peaks
# u = runif(npeaks, min=min(x), max=max(x)) # unknown peak locations
# w = rep(5,npeaks) # unknown peak widths
# h = runif(npeaks, min=0, max=1000) # unknown peak heights
# y = sumgauspeaks(x, u, w, h)
# plot(x,y,type="l")

subtract_one_gaussian <- function(x, y, width) {
  max_ix <- which.max(y)
  indices <- max_ix + seq(-5*ceiling(width), 5*ceiling(width))
  indices <- indices[indices > 0]
  indices <- indices[indices < length(y) + 1]
  x_hat <- x[indices] 
  y_hat <- gauspeak(x_hat, x[max_ix], width, y[max_ix])
  y_new <- y 
  y_new[indices] <- abs(y_new[indices] - y_hat)
  result$y_new <- y_new
  result$max_ix <- max_ix
  result$x_hat <- x_hat
  result$y_hat <- y_hat
  return(result)
}

find_best_width <- function(x,y, min_width, max_width)
{
  widths <- seq(min_width, max_width, 0.2)
  errors <- c()
  for (width in widths) 
  {
    result <- subtract_one_gaussian(x, y, width)
    errors <-  c(errors,sum(abs(result$y_new)))
  }
  
  return(widths[which.min(errors)])
}

find_all_gaussians <- function(x,y) 
{
  best_width <- find_best_width(x,y,1,10)
  result$widths <- c(best_width)
  subtraction_result <- subtract_one_gaussian(x, y, best_width)
  result$locations <- c(result$max_ix)
  for (i in seq(1,40)) {
    best_width <- find_best_width(x,subtraction_result$y_new,1,10)
    result$widths <- c(result$widths, best_width)
    subtraction_result <- subtract_one_gaussian(x, subtraction_result$y_new,best_width)
    result$locations <- c(result$locations, subtraction_result$max_ix)
  }
  
  return(result)
}


gaussians <- find_all_gaussians(x,y)
plot(seq(1,length(gaussians$widths)), gaussians$widths)
lines(c(1,length(gaussians$widths)), mean(gaussians$widths)*c(1,1), col='red')
lines(c(1,length(gaussians$widths)), 5*c(1,1), col='blue')


# FUNCTION TO CALCULATE INFORMATION CRITERIA AIC & BIC GIVING GOODNESS OF FIT ####
# SSs are calculated on given transformed scale (e.g. sqrt() variance stabilizing function for Poisson data)
IC = function (y, yhat, npars, transf = function (y) sqrt(y)) { 
  nobs = length(y)
  RSS = sum((transf(y)-transf(yhat))^2) # residual SS on sqrt() scale
  min2LL = nobs + nobs*log(2*pi) + nobs*log(RSS/nobs) # -2*logL
  AIC = min2LL + 2*npars 
  BIC = min2LL + log(nobs)*npars
  return(list(AIC=AIC, BIC=BIC))
}

# FUNCTION GIVING FIT QUALITY (BIC) IN FUNCTION OF GAUSSIAN PEAK WIDTH USED IN BANDED COVARIATE MATRIX OF NNLS FIT
fitqual = function(width) {
  bandedM = do.call(cbind, lapply(1:length(y), function (u) gauspeak(1:length(y), u=u, w=width, h=1)))
  require(nnls)
  fit = nnls(A=bandedM, b=y)
  fitqual = IC(y, fit$fitted, npars=sum(fit$x>0), transf =  function(y) sqrt(y))$BIC # fit$deviance=RSS
  return(fitqual) 
} 
system.time(what <- optimize(fitqual, interval=c(3, 6), maximum=FALSE, tol=1E-3)$minimum) # 13 s
what # estimated Gaussian peak width: 5.02 
BICvals <- sapply(seq(1,10,length.out=100), function(width) fitqual(width) ) 
dev.off()
plot(seq(1,10,length.out=100), BICvals, type="l", ylab="Bayesian Information Criterion (BIC)", xlab="Gaussian peak width")

