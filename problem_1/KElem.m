function [ke] = KElem(elem,k,X,T,ie,nu,E,h)
%elementary matrix
%Entrées:
%          k: lienar or quadratic
%          X: Coordinates matrix 
%          T: rectangles
%          ie: present element index

%Sorties:
%          Ke: elementary matrix ke
% 

alpha_e=1;
beta_e=1;
if elem == 0
    if k == 1
        Ngeom = 4;
    elseif k == 2
        Ngeom=9;
    end
end

if elem==0

    if k==1 


elem_k_11 = zeros(4,4);
elem_k_11(:,1) = [4*beta_e+1.5*alpha_e*(1-nu);3*(1+nu);-8*beta_e+3*alpha_e*(1-nu);3*(3*nu-1)];
elem_k_11(2:4,2) = [4*alpha_e+1.5*beta_e*(1-nu);-3*(3*nu-1);4*alpha_e-3*beta_e*(1-nu)];
elem_k_11(3:4,3) = [4*beta_e+1.5*alpha_e*(1-nu);-3*(1+nu)];
elem_k_11(4,4) = 4*alpha_e+1.5*beta_e*(1-nu);

elem_k_11 = elem_k_11 + elem_k_11';


elem_k_21 = zeros(4,4);
elem_k_21(:,1) = [-2*beta_e-1.5*alpha_e*(1-nu);-3*(1+nu);4*beta_e-3*alpha_e*(1-nu);-3*(3*nu-1)];
elem_k_21(2:4,2) = [-2*alpha_e-1.5*beta_e*(1-nu);3*(3*nu-1);-8*alpha_e+3*beta_e*(1-nu)];
elem_k_21(3:4,3) = [-2*beta_e-1.5*alpha_e*(1-nu);3*(1+nu)];
elem_k_21(4,4) = -2*alpha_e-1.5*beta_e*(1-nu);

elem_k_21 = elem_k_21 + elem_k_21';

elem_k_22 = elem_k_11;

ke = [elem_k_11 elem_k_21';elem_k_21 elem_k_22]*E*h/(24*(1-nu^2));


    
     end
end


end

