T <- 1024

t <- seq(1,T,1)

Nchanges <- 10

times_for_changes_for_x1 <- sort(runif(Nchanges,T/10,9*T/10))
differences_in_delay <- round(runif(Nchanges,-5,5))
times_for_changes_for_x2 <- times_for_changes_for_x1 + differences_in_delay
changes_for_x1 <- runif(Nchanges,-5,5)

x1 <- 0*t
x2 <- 0*t
change_no_x1 <- 1
change_no_x2 <- 1

for (tm in t)
{
  if ( (change_no_x1 <= Nchanges) && (tm > times_for_changes_for_x1[change_no_x1]))
  {
    x1[tm] <- x1[tm] + changes_for_x1[change_no_x1]
    change_no_x1 <- change_no_x1 + 1
  }
  else
  {
    if (tm > 1)
    {
      x1[tm] = x1[tm-1]
    }
  }
  if ( (change_no_x2 <= Nchanges) && (tm > times_for_changes_for_x2[change_no_x2]))
  {
    x2[tm] <- x2[tm] + changes_for_x1[change_no_x2]
    change_no_x2 <- change_no_x2 + 1
  }
  else
  {
    if (tm > 1)
    {
      x2[tm] = x2[tm-1]
    }
  }
}

plot(x1,type='l')
lines(x2,col="red")

plot(abs(diff(x1)>0)*1, type='l')
lines(abs(diff(x2)>0)*1, col="red")


print(differences_in_delay)
print(t[which(abs(diff(x2))>0)] - t[which(abs(diff(x1))>0)])
