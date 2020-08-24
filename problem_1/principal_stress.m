function [pr_sigma_xx, pr_sigma_yy] = principal_stress(T, integ_sigma_xx,integ_sigma_yy,integ_sigma_xy)
%-----------------
%finds the principal stresses, a vector of size 4 times the number of
%elements, a value for each node for each element in the domain.
%-----------------
TT=size(T,1);
pr_sigma_xx=zeros(4*TT,1);
pr_sigma_yy=zeros(4*TT,1);
   

for i=1:TT

  for j=1:4
  thetap = 0.5 * atan(2*integ_sigma_xy(4*i-(4-j))/(integ_sigma_xx(4*i-(4-j))-integ_sigma_yy(4*i-(4-j))));
  
  Q = [cos(thetap) sin(thetap);-sin(thetap) cos(thetap)];
  
  sigma_principal = Q * [integ_sigma_xx(4*i-(4-j)) integ_sigma_xy(4*i-(4-j));integ_sigma_xy(4*i-(4-j)) integ_sigma_yy(4*i-(4-j))] * Q';
  
  pr_sigma_xx(4*i-(4-j)) = sigma_principal(1,1);
  pr_sigma_yy(4*i-(4-j)) = sigma_principal(2,2);
  
  end
  
end

    
end
