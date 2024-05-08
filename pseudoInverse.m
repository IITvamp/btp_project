function [P_new] = pseudoInverse(P_old, B_old, u)
 
   C = u'*u;
   B = B_old'*u;
   X = P_old + P_old*B*(C - (B'*P_old*B))*B'*P_old;

   xbc_inv = -1*(X*B)/C;
   P_new = [X                     xbc_inv
            xbc_inv'            (B'*X*B/(C^2)) + 1/C];
   
 
end