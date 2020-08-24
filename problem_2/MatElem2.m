function [Ke] = MatElem2(elem,k,X,T,ie,phi,grad,Xgauss,Wgauss,gamma,alpha)
%Elementary matrix function
%Inputs:
%          k: Element type (Liner or quadratic) (Pk)
%          X: Coordinates of the mesh.
%          T: Rectangles indexes.
%          ie: index of the current element.
%         phi: Hat fonctions in Reference element
%        grad: Gradient of the hat function in the reference element
%      Xgauss: Gauss points in reference element
%      Wgauss: Gauss weights
%Outputs:
%          Ke: elementary matrix (of gradients)
% 
if elem == 0
    if k == 1
        Ngeom = 4;
    elseif k == 2
        Ngeom=9;
    end
elseif elem == 1  
    if k == 1
        Ngeom = 3;
    elseif k == 2 
        Ngeom = 6;
    elseif k == 3
        Ngeom = 9;
    end
end

if elem==1
if k==1 
%      Current rectangle nodes 
x=X(T(ie,1:Ngeom),:);
%      Variable changing Matrix
J=[(x(2,:)-x(1,:))',(x(3,:)-x(1,:))'];
%
%       Reference Element Area
     air=abs(det([0 1 0;0 0 1;1 1 1]));
%  
   KKe=zeros(Ngeom);
%
%elementary matrix Ke 
   for i=1:Ngeom
     for j=i:Ngeom
      for N=1:size(Wgauss,2)
        KKe(i,j)=KKe(i,j)+Wgauss(N)*(J'\grad(:,i))'*(J'\grad(:,j));
        KKe(j,i)=KKe(i,j);
      end
     end
   end
   Ke=det(J)*KKe;
 %
    Mass=zeros(Ngeom);
%
%elementary matrix Ke 
   for i=1:Ngeom
     for j=i:Ngeom
      for N=1:size(Wgauss,2)
        Mass(i,j)=Mass(i,j)+Wgauss(N)*phi(N,i)*phi(N,j);
        Mass(j,i)=Mass(i,j);
      end
     end
   end
   Ke=gamma*det(J)*Mass+alpha*Ke;

 
 
else 
        error(' ce type Pk n est pas encore programmé') 
end  
end

if elem==0
    
    %      current rectangle nodes 
x=X(T(ie,1:Ngeom),:);
s = Xgauss(:,1); 
t = Xgauss(:,2); 


    if k==1 


%      a and b so that        ; x=a1+a2*s+a3*t+a4*st
%                               y=b1+b2*s+b3*t+b4*st
ab=0.25*[x(2,:)+x(3,:)+x(1,:)+x(4,:);x(2,:)+x(3,:)-x(1,:)-x(4,:);...
    -x(2,:)+x(3,:)-x(1,:)+x(4,:);-x(2,:)+x(3,:)+x(1,:)-x(4,:)];



%      transpose of the jacobian

Jtr=[ab(2,1)+ab(4,1)*t ab(2,2)+ab(4,2)*t;...
    ab(3,1)+ab(4,1)*s ab(3,2)+ab(4,2)*s];


Ngauss=size(Wgauss,2);
KKe=zeros(Ngeom);
   for i=1:Ngeom
     for j=i:Ngeom
      for N=1:size(Wgauss,2)
        Determinant=det(Jtr([N N+Ngauss],:)); %knowing that Det(J)=Det(J')
        KKe(i,j)=KKe(i,j)+Wgauss(N)*Determinant*(((Jtr([N N+Ngauss],:)\grad([N N+Ngauss],i))')*(Jtr([N N+Ngauss],:)\grad([N N+Ngauss],j)));          
        KKe(j,i)=KKe(i,j);
      end
     end
   end
   
Mass=zeros(Ngeom);
   for i=1:Ngeom
     for j=i:Ngeom
      for N=1:size(Wgauss,2)
        Determinant=det(Jtr([N N+Ngauss],:)); %knowing that Det(J)=Det(J')
        Mass(i,j)=Mass(i,j)+Wgauss(N)*Determinant*phi(N,i)*phi(N,j);          
        Mass(j,i)=Mass(i,j);
      end
     end
   end
   
   
   Ke=alpha*KKe+gamma*Mass;
   
    elseif k==2
        
        ab=[0.5*x(4,:)-x(5,:)+0.5*x(6,:);
            0.5*x(2,:)-x(5,:)+0.5*x(8,:);
            (1/4)*x(1,:)-(1/2)*x(2,:)+(1/4)*x(3,:)-(1/2)*x(4,:)+x(5,:)-(1/2)*x(6,:)+(1/4)*x(7,:)-(1/2)*x(8,:)+(1/4)*x(9,:);
        -(1/4)*x(1,:)+(1/2)*x(2,:)-(1/4)*x(3,:)+(1/4)*x(7,:)-(1/2)*x(8,:)+(1/4)*x(9,:);
        -(1/4)*x(1,:)+(1/4)*x(3,:)+(1/2)*x(4,:)-(1/2)*x(6,:)-(1/4)*x(7,:)+(1/4)*x(9,:);
        (1/4)*x(1,:)-(1/4)*x(3,:)-(1/4)*x(7,:)+(1/4)*x(9,:);
        -(1/2)*x(4,:)+(1/2)*x(6,:);
        -(1/2)*x(2,:)+(1/2)*x(8,:);
        x(5,:)];
    


    %Variable changing matrix
    Jtr=[2*ab(1,1)*s+2*ab(3,1)*s.*(t.^2)+2*ab(4,1)*s.*t+ab(5,1)*(t.^2)+ab(6,1)*t+ab(7,1),...
    2*ab(1,2)*s+2*ab(3,2)*s.*(t.^2)+2*ab(4,2)*s.*t+ab(5,2)*t.^2+ab(6,2)*t+ab(7,2);...
    2*ab(2,1)*t+2*ab(3,1)*t.*(s.^2)+ab(4,1)*(s.^2)+2*ab(5,1)*s.*t+ab(6,1)*s+ab(8,1),...
    2*ab(2,2)*t+2*ab(3,2)*t.*(s.^2)+ab(4,2)*(s.^2)+2*ab(5,2)*s.*t+ab(6,2)*s+ab(8,2)];
    % Determinant
    Determinant=((2*ab(1,1)*s+2*ab(3,1)*s.*(t.^2)+2*ab(4,1)*s.*t+ab(5,1)*(t.^2)+ab(6,1)*t+ab(7,1)).*...
    (2*ab(2,2)*t+2*ab(3,2)*t.*(s.^2)+ab(4,2)*(s.^2)+2*ab(5,2)*s.*t+ab(6,2)*s+ab(8,2)))-...
    ((2*ab(2,1)*t+2*ab(3,1)*t.*(s.^2)+ab(4,1)*(s.^2)+2*ab(5,1)*s.*t+ab(6,1)*s+ab(8,1)).*...
    (2*ab(1,2)*s+2*ab(3,2)*s.*(t.^2)+2*ab(4,2)*s.*t+ab(5,2)*(t.^2)+ab(6,2)*t+ab(7,2)));

Ngauss=size(Wgauss,2);
KKe=zeros(Ngeom);
   for i=1:Ngeom
     for j=i:Ngeom
      for N=1:size(Wgauss,2)
        KKe(i,j)=KKe(i,j)+Wgauss(N)*Determinant(N)*(((Jtr([N N+Ngauss],:)\grad([N N+Ngauss],i))')*(Jtr([N N+Ngauss],:)\grad([N N+Ngauss],j)));          
        KKe(j,i)=KKe(i,j);
      end
     end
   end
   
Mass=zeros(Ngeom);
   for i=1:Ngeom
     for j=i:Ngeom
      for N=1:size(Wgauss,2)
        Mass(i,j)=Mass(i,j)+Wgauss(N)*Determinant(N)*phi(N,i)*phi(N,j);          
        Mass(j,i)=Mass(i,j);
      end
     end
   end
   
   
   Ke=alpha*KKe+gamma*Mass;
        
    end
end


end

