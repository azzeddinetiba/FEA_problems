function [flux_x, flux_y] = flux(k,T, U)
%-----------------
%finds the strains xx, yy, and xy, a vector of size 4 times the number of
%elements, a value for each node for each element in the domain.
%-----------------
TT=size(T,1);
flux_x=zeros(4*TT,1);
flux_y=zeros(4*TT,1);


b=5e-2;
h=5e-2;

for i=1:TT
   xe=[-b -h;b -h;b h;-b h];
  % to speed up the code and since we know h=b=5e-2 we defined it outside
  % of the loop
  %b = (xe(3,1)-xe(4,1))/2;
  %h = (xe(4,2)-xe(1,2))/2;
  
    Te = T(i,:);

  for j=1:4
      
    B = 1/(4*b*h) * ...
                    [-(h-xe(j,2))     (h-xe(j,2))         (h+xe(j,2))    -(h+xe(j,2)) ;...
                     -(b-xe(j,1))    -(b+xe(j,1))         (b+xe(j,1))     (b-xe(j,1))];
                 
    FLUX=B*U(Te);
    flux_x(4*i-(4-j))= - k * FLUX(1);
    flux_y(4*i-(4-j))= - k * FLUX(2);
    
  end
    

end