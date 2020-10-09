 A2 = 10; D1 = 15; teta1 = 0; teta2 = pi/2; d3 = 15;
% syms A2 D1 teta1 teta2 d3
H = Rz(teta1) * Tz(D1) * Ry(teta2) * Tx(A2) * Tx(d3)