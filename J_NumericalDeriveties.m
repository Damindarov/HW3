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

Jq1 = [simplify(J1),simplify(J2),simplify(J3)]%find jacobian