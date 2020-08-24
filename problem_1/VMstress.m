function [VM_sigma] = VMstress(sigma_xx,sigma_yy,sigma_xy)
%-----------------
%finds the Von Mises stresses, a vector of size 4 times the number of
%elements, a value for each node for each element in the domain.
%-----------------

    VM_sigma = (0.5*((sigma_xx-sigma_yy).^2+6*(sigma_xy.^2))).^0.5;
    
end
