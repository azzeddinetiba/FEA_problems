function [Kb,Fb,U] = MEF2D(f,elem,k,X,T,left_b,right_b,Ngauss,gamma,alpha)
% equation alpha*laplace(u)=f on Omega with u|Omega=0
% by Galerkin Pk finite elements
%Inputs
%       elem:  element type (0 for rectangles and 1 for triangles)
%          k:  element type (Linear or quadratic)
%          X:  
%          T:  
%          b:  border nodes
%     Ngauss:  Gauss number of points
%Outputs:
%          U:  Solution Vector
%
% --------Gauss-----------
[Xgauss,Wgauss]=Quadrature(elem, Ngauss);
%
%---------Hat functions------------
if elem==1
[phi,grad] = FoncChap(k,Xgauss);
elseif elem==0
[phi,grad] = FoncChapQ(k,Xgauss);
end
%
%-------- Assembly--------------------
[ K,F ] = Assembly2D(elem,k,X,T,f,phi,grad,Xgauss,Wgauss,Ngauss,gamma,alpha);
%
%--------Boundary conditions----------
%zeros on the rows of the dirichlet condition nodes
K(left_b,:)=0; K(right_b,:)=0;
F(left_b)=20+273.15;
F(right_b)=50+273.15;
%ones in diagonals of dirichelt condition
K(left_b,left_b)=eye(length(left_b),length(left_b));
K(right_b,right_b)=eye(length(right_b),length(right_b));
% K et F after boundary conditions
Kb=K; Fb=F; 
%
U=Kb\Fb;
end