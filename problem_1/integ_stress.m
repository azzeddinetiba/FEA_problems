function [integ_sigma_xx, integ_sigma_yy, integ_sigma_xy] = integ_stress(T,integ_eps_xx,integ_eps_yy,integ_eps_xy,E,nu)
%-------------------------
%stresses at integration points
%-------------------------
TT=size(T,1);
integ_sigma_xx=zeros(4*TT,1);
integ_sigma_yy=zeros(4*TT,1);
integ_sigma_xy=zeros(4*TT,1);


for i=1:TT

  for j=1:4
      
    D = [1 nu 0;nu 1 0;0 0 0.5*(1-nu)] * E/(1-nu^2);
    STRESS = D * [integ_eps_xx(4*i-(4-j));
                  integ_eps_yy(4*i-(4-j));
                  integ_eps_xy(4*i-(4-j))];
            
    integ_sigma_xx(4*i-(4-j)) = STRESS(1);
    integ_sigma_yy(4*i-(4-j)) = STRESS(2);
    integ_sigma_xy(4*i-(4-j)) = STRESS(3);
    
    
  end
    

end