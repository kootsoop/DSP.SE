# 42090

N <- 10
sample <- 100
xLength <- N + sample - 1
x <- rnorm(xLength)

#x1=zeros(Nsamples,N);
x1 <- rep(0,sample*N)
dim(x1) <- c(sample,N)

#for i=1:N
for (i in seq(1,N))
{
  #x1(:,i)=x(N-(i-1):end-(i-1));
  x1[,i] <- x[(N-(i-1)):(xLength-(i-1))]   
#end
}
#R=x1'*x1/Nsample;
R1 <- (t(x1) %*% x1)

#############
#a=size(h);
#if a(1)>a(2)
#h=h';
#    end
#    m=length(h); m --> xLength

#    for k=1:N
R <- rep(0,N)
for (k in seq(1,N))
{
#        if k<=m
  if (k <= xLength)
  {
#            R(k)=h(k:m)*h(1:m-k+1)'';
      R[k] <- sum(x[k:xLength] * x[1:(xLength-k+1)])
  }
#        else
  else
  {
    #          R(k)=0; 
    R[k] <= 0    
  }
#        end
#    end
}
#    R=toeplitz(R);
R2 <- toeplitz(R)


plot(R1[1,], type = 'l')
lines(R2[1,], col='red')
