function [integ_eps_xx, integ_eps_yy, integ_eps_xy] = integ_strain(T,U,Xgauss)
%-------------------------
%strains at integration points
%-------------------------
TT=size(T,1);
integ_eps_xx=zeros(4*TT,1);
integ_eps_yy=zeros(4*TT,1);
integ_eps_xy=zeros(4*TT,1);


b=5e-2;
h=5e-2;

for i=1:TT
  xe=Xgauss;
  % to speed up the code and since we know h=b=5e-2 we defined it outside
  % of the loop
  %b = (xe(3,1)-xe(4,1))/2;
  %h = (xe(4,2)-xe(1,2))/2;
  
    Te = 2*T(i,:);
    Te1 = Te-1;
    Tee = [Te1(1) Te(1) Te1(2) Te(2) Te1(3) Te(3) Te1(4) Te(4)];

  for j=1:4
      

    B = 1/(4*b*h) * ...
                    [-(h-h*xe(j,2))      0           (h-h*xe(j,2))          0          (h+h*xe(j,2))           0           -(h+h*xe(j,2))        0;...
                     0              -(b-b*xe(j,1))        0           -(b+b*xe(j,1))       0              (b+b*xe(j,1))         0            (b-b*xe(j,1));...
                    -(b-b*xe(j,1))  -(h-h*xe(j,2))   -(b+b*xe(j,1))    (h-b*xe(j,2))    (b+b*xe(j,1))     (h+h*xe(j,2))    (b-b*xe(j,1))    -(h+h*xe(j,2))];
                 
    STRAIN=B*U(Tee);
    integ_eps_xx(4*i-(4-j))=STRAIN(1);
    integ_eps_yy(4*i-(4-j))=STRAIN(2);
    integ_eps_xy(4*i-(4-j))=STRAIN(3);
    
  end
    

end