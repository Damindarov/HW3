A2 = 10; D1 = 15; x = 0; y = 15; z = 15;
teta1 = atan2(y,x);
teta2 = atan2(z-D1,(x^2 + y^2)^(1/2));
d3 = ((x^2 + y^2)^(1/2)) * cos(teta2) - A2;
rez1 = [teta1,teta2,d3]
rez2 = [teta1-pi,teta2+pi,d3] %hehre iw two solves because ...
...joint 1 we can rotate to angle + pi and joint2 rotate to angle -pi and state in one position