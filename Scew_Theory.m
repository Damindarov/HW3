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
J = simplify ([J1,J2,J3])
