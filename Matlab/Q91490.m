% 91490

d = 1;
No = logspace(-10,0,1000);
Pe1 = 1/16*(8*qfunc(2*d./sqrt(2*No)) + 8*qfunc(2*d./sqrt(2*No)))
Pe2 = 1/16*(8*qfunc(2*d./sqrt(2*No)) + 4*qfunc(2*sqrt(2)*d./sqrt(2*No)) + 8*qfunc(2*d./sqrt(2*No)))

plot(No, Pe1)
hold on;
plot(No, Pe2)
hold off;
