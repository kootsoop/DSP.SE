#43794
#N = 100;
N <- 21
#dsfactor = 3;
dsfactor <- 2
#H = dsfactor*3;
H <- 4
#x = linspace(0,10,N);
x1 <- seq(0,10,10/(N-1))
#x2 <- seq(0,10*(N-1)/N,10/N)
#y = sind(18*x);
y1 <- c(seq(1,11), seq(10,1,-1))
#y1 <- sin(18*x1/180*pi)
#y2 <- sin(18*x2/180*pi)
#y3 <- sin(36*x1/180*pi)
#y4 <- sin(36*x2/180*pi)
#h = ones(H,1);
h <- rep(1,H)

#convyh = conv(y,h);
convy1h <- filter(y1,h)
#convy2h <- filter(y2,h)
#convy3h <- filter(y3,h)
#convy4h <- filter(y4,h)

downsample <- function(signal, factor) 
{
  return(signal[seq(1,length(signal), factor)])
}

#convyh_ds = downsample(convyh,dsfactor)./H;
convy1h_ds <- downsample(convy1h, dsfactor)/H
##convy2h_ds <- downsample(convy2h, dsfactor)/H
#convy3h_ds <- downsample(convy3h, dsfactor)/H
#convy4h_ds <- downsample(convy4h, dsfactor)/H
#convyh_ds3 = conv(downsample(y,dsfactor),downsample(h,dsfactor))./(ceil(H/dsfactor));
convy1h_ds3 <- filter(downsample(y1,dsfactor), downsample(h,dsfactor))/ceiling(H/dsfactor)
#convy2h_ds3 <- filter(downsample(y2,dsfactor), downsample(h,dsfactor))/ceiling(H/dsfactor)
#convy3h_ds3 <- filter(downsample(y3,dsfactor), downsample(h,dsfactor))/ceiling(H/dsfactor)
#convy4h_ds3 <- filter(downsample(y4,dsfactor), downsample(h,dsfactor))/ceiling(H/dsfactor)
#figure;
#plot(convyh_ds,'DisplayName','downsample(conv)','LineWidth',1);
#hold on;
#plot(convyh_ds3,'DisplayName','conv(downsample)','LineWidth',1);
#grid minor
#legend('show');
#line([0 length(convyh_ds2)],[0 0],'LineStyle','--');

#par(mfrow=c(2,2))
plot(seq(1,11)-0.25,convy1h_ds,col='black')
#lines(seq(1,11)-0.27,convy1h_ds, col='blue')
lines(convy1h_ds3, col='red')

#plot(convy2h_ds)
#lines(convy2h_ds3, col='red')

#plot(convy3h_ds)
#lines(convy3h_ds3, col='red')

#plot(convy4h_ds)
#lines(convy4h_ds3, col='red')
