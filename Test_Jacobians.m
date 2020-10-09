
JC = Jacobian_classical();
JN = Jacobian_Numerical();
JS = Jacobian_Scew();
JC - JN
JC - JS
JN-JS


function J =Jacobian_classical()
syms A1 A2 teta2 teta1 d3 D1
% A2 = 10;  teta2 = pi/2; teta1 = 0; d3 = 5; D1=15;


x = - A2*cos(teta2)*sin(teta1) - d3*cos(teta2)*sin(teta1);
y = A2*cos(teta1)*cos(teta2) + d3*cos(teta1)*cos(teta2);
z = D1 + A2*sin(teta2) + d3*sin(teta2);
J = [diff(x,teta1) diff(x,teta2) diff(x,d3); 
    diff(y,teta1) diff(y,teta2) diff(y,d3);
    diff(z,teta1) diff(z,teta2) diff(z,d3);
    0 cos(teta1) 0; 0 sin(teta1) 0; 1 0 0];
J = simplify(J);
end

function J =Jacobian_Numerical()
syms A1 A2 teta2 teta1 d3 D1 real
H = Rz(teta1) * Tz(D1) * Rx(teta2) * Ty(A2) * Ty(d3);
H = simplify(H);
R = simplify(H(1:3,1:3));
Td =  Rzd(teta1) * Tz(D1) * Rx(teta2) * Ty(A2) * Ty(d3) * [R^-1 zeros(3,1); 0 0 0 1];%with taking Rzd
J1 = [Td(1,4),Td(2,4),Td(3,4),Td(3,2),Td(1,3),Td(2,1)]';%find element of jacobian

Td =  Rz(teta1) * Tz(D1) * Rxd(teta2) * Ty(A2) * Ty(d3) * [R^-1 zeros(3,1); 0 0 0 1];%with taking Rxd
J2 = [Td(1,4),Td(2,4),Td(3,4),Td(3,2),Td(1,3),Td(2,1)]';%find element of jacobian

Td =  Rz(teta1) * Tz(D1) * Rx(teta2) * Ty(A2) * Tyd(d3) * [R^-1 zeros(3,1); 0 0 0 1];%with taking Tyd
J3 = [Td(1,4),Td(2,4),Td(3,4),Td(3,2),Td(1,3),Td(2,1)]';%find element of jacobian

J = [simplify(J1),simplify(J2),simplify(J3)];%find jacobian
end

function J =Jacobian_Scew()
syms A1 A2 teta2 teta1 d3 D1
T00 = eye(4);%diagonal matrix from 0 to 0
T01 = Rz(teta1) * Tz(D1);%matrix from 0 to 1 joint
T02 = Rz(teta1) * Tz(D1) * Rx(teta2); %matrix from 0 to 2 joint
T03 = Rz(teta1) * Tz(D1) * Rx(teta2) * Ty(A2) * Ty(d3);%matrix from 0 to 3 joint
Z0 = [0;0;1];%third column of T00
Z1 = [cos(teta1);sin(teta1);0];%first column of T01
Z2 = [-cos(teta2)*sin(teta1);cos(teta1)*cos(teta2);sin(teta2)];%second column of T02
O3 = [- A2*cos(teta2)*sin(teta1) - d3*cos(teta2)*sin(teta1);A2*cos(teta1)*cos(teta2) + d3*cos(teta1)*cos(teta2);D1 + A2*sin(teta2) + d3*sin(teta2)];
O0 = [0;0;0];
O1 = [0;0;D1];
J1 = [cross(Z0,O3-O0);Z0];
J2 = [cross(Z1,O3-O1);Z1];
J3 = [Z2; 0; 0; 0];
J = simplify ([J1,J2,J3]);
end
