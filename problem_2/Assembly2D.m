function [ K,F ] = Assembly2D(elem,k,X,T,f,phi,grad,Xgauss,Wgauss,Ngauss,gamma,alpha)
% Assemblage des matrices �l�mentaires "Ke" dans la matrice globale K
% Assemblage des seconds membres �l�mentaires "Fe" dans le second... 
% membre global F
% On utilise la fonction "MatElem(k,X,T,ie,f,phi,grad,Xgauss,Wgauss)"
% 
%Entr�es:
%       elem:  type d'�l�ment (0 pour quadrilat�res et 1 pour triangles)
%          X: table des coordonn�es
%          T: tbale des connectivit�s
% 
Nn=size(X,1); %nodes number
Nt=size(T,1);  % elements number
%
K=zeros(Nn,Nn);% initialisation of K 
F=zeros(Nn,1);% initialisation of F
%
for ie = 1:Nt
    Tie =T(ie,:);
    [Ke] =MatElem2(elem,k,X,T,ie,phi,grad,Xgauss,Wgauss,gamma,alpha);
    K(Tie,Tie)=K(Tie,Tie)+Ke;
    clear Ke Fe; 
end
end

