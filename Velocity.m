D1 = 15; A2 = 10;
time = [];
t = 0;
v = [];
counter = 0;
while (t < 15)
    K = Jacobian(D1,A2,sin(t),cos(2*t),sin(3*t));%find J5acobian
    q_dot = [cos(t);-2*sin(2*t);3*cos(3*t)];%find derivities
    v = [v K * q_dot];  %find array of velocities and omega's
    time = [time t+0.001];%time array ms
    t = t+0.001;%+ msec for next step
 end

plot(time,v(1,:),'g',time,v(2,:),'r',time, v(3,:),'b',time,v(4,:),time,v(4,:),time,v(5,:),time,v(6,:));
legend('vx','vy','vz','omegax','omegay','omegaz');% plot and create legend
function J =Jacobian(D1,A2,teta1,teta2,d3)
H = Rz(teta1) * Tz(D1) * Rx(teta2) * Ty(A2) * Ty(d3);
R = H(1:3,1:3);
Td =  Rzd(teta1) * Tz(D1) * Rx(teta2) * Ty(A2) * Ty(d3) * [R^-1 zeros(3,1); 0 0 0 1];
J1 = [Td(1,4),Td(2,4),Td(3,4),Td(3,2),Td(1,3),Td(2,1)]';

Td =  Rz(teta1) * Tz(D1) * Rxd(teta2) * Ty(A2) * Ty(d3) * [R^-1 zeros(3,1); 0 0 0 1];
J2 = [Td(1,4),Td(2,4),Td(3,4),Td(3,2),Td(1,3),Td(2,1)]';

Td =  Rz(teta1) * Tz(D1) * Rx(teta2) * Ty(A2) * Tyd(d3) * [R^-1 zeros(3,1); 0 0 0 1];
J3 = [Td(1,4),Td(2,4),Td(3,4),Td(3,2),Td(1,3),Td(2,1)]';

J = [J1,J2,J3];
end