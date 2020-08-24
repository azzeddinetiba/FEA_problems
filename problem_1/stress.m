function [sigma_xx, sigma_yy, sigma_xy] = stress(T,eps_xx,eps_yy,eps_xy,E,nu)
%-----------------
%finds the stresses xx, yy and xy, a vector of size 4 times the number of
%elements, a value for each node for each element in the domain.
%-----------------
TT=size(T,1);
sigma_xx=zeros(4*TT,1);
sigma_yy=zeros(4*TT,1);
sigma_xy=zeros(4*TT,1);


for i=1:TT

  for j=1:4
      
    D = [1 nu 0;nu 1 0;0 0 0.5*(1-nu)] * E/(1-nu^2);
    STRESS=D * [eps_xx(4*i-(4-j));
                eps_yy(4*i-(4-j));
                eps_xy(4*i-(4-j))];
            
    sigma_xx(4*i-(4-j)) = STRESS(1);
    sigma_yy(4*i-(4-j)) = STRESS(2);
    sigma_xy(4*i-(4-j)) = STRESS(3);
    
    
  end
    

end