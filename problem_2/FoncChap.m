function [phi,grad] = FoncChap(k,Xgauss)
%shape functions

%
s = Xgauss(:,1); 
t = Xgauss(:,2); 
if k == 1  %P1
        phi   = [1-(s+t),s,t]; 
        grad  = [-ones(2,1),eye(2)]; 
end

