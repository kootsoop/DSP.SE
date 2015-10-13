A <- read.csv("Q26261.csv")
x <- A[1:45,2]
y <- A[1:45,4]

x2 <- matrix(x, nrow = 5, byrow = TRUE)
y2 <- matrix(y, nrow = 5, byrow = TRUE)

cor(x,y)
cor(x2,y2)
plot(x,y)