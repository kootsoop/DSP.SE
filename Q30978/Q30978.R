#30978
# install.packages("wavelets")
library(wavelets)
x<-c(7, 5, 5, 3, 3, 3, 4, 6)
w <- dwt(x, filter="haar",n.levels = 3)
rec<-idwt(w)


w2 <- w

w2@V$V3 <- NULL
w2@W$W3 <- NULL
w2@V$V2 <- NULL
w2@W$W2 <- NULL


trunc <- idwt(w2)

trunc

