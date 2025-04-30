function [f]=instfreq(s)

z=unwrap(angle(s));
f=diff(z);

end

