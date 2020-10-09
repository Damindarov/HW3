


% A = Jacobian(D1,A2,teta1,teta2,d3);
matrix_cond = [];
for i = -pi:0.2:pi
   for j = -pi:0.2:pi
       for k = -A2:0.2:A2/2
        A = Jacobian(D1,A2,i,j,k);
         [U,S,V] = svd(A);
        if S(1,1) < 0.5
            disp('Singularity');
        elseif S(2,2) < 0.5 
            disp('Singularity');
        elseif S(3,3) < 0.5 
            disp('Singularity');
        end   
        H = Rz(i) * Tz(D1) * Ry(j) * Tx(A2) * Tx(k);
        matrix_cond = [matrix_cond [H(1,4);H(2,4);H(3,4);cond(A)]];
       end
   end    
end 
% A2 = 10;  teta2 = pi/2; teta1 =0; d3 = 5; D1=15;
% A = Jacobian(D1,A2,teta1,teta2,d3);
%  [U,S,V] = svd(A);
% S
% figure
% h = scatter3(matrix_cond(1,:), matrix_cond(2,:), matrix_cond(3,:), 20, matrix_cond(4,:), 'MarkerFaceColor', 'Flat');
% colorbar(); 
% caxis([min(matrix_cond(4,:)), max(matrix_cond(4,:))])
% scatter3(matrix_cond(1,:),matrix_cond(2,:),matrix_cond(3,:))
% [U,S,V] = svd(A);
% cond(A)

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