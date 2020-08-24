function [ K,F ] = Assembly2D(elem,k,X,T,f,phi,grad,Xgauss,Wgauss,Ngauss,gamma,alpha)
% Assemblage des matrices élémentaires "Ke" dans la matrice globale K
% Assemblage des seconds membres élémentaires "Fe" dans le second... 
% membre global F
% On utilise la fonction "MatElem(k,X,T,ie,f,phi,grad,Xgauss,Wgauss)"
% 
%Entrées:
%       elem:  type d'élément (0 pour quadrilatères et 1 pour triangles)
%          X: table des coordonnées
%          T: tbale des connectivités
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

