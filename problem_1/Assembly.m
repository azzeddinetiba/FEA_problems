function [ Kb,Fb, K, F ] = Assembly(elem,k,X,T,upper_b_1,upper_b_2,upper_b_3,bottom_b,f,nu,Young,h,Xgauss,Wgauss,Ngauss,A,B,C,D,E)
% Assembly of the elementary matrixes Ke in the global stiffeness matrix K
% Assembly of the elementary matrixes in the global load vector   F
% We use the function "KElem"
% 
%Entrées:
%       elem:  element type (0 for quadrilaterals and 1 for triangles)
%          X: 
%          T: 
% 
Nn=2*size(X,1); %Nodes number
Nt=size(T,1);  % Elements number
%
K=zeros(Nn,Nn);% initialisation of K 
F=zeros(Nn,1);% initialisation of F 
%
for ie = 1:Nt
    Tie = 2*T(ie,:);
    Tie_1 = Tie - ones(1,4);
    Tie = [Tie_1(1) Tie(1) Tie_1(2) Tie(2) Tie_1(3) Tie(3) Tie_1(4) Tie(4)];
    [Ke] = KElem(elem,k,X,T,ie,nu,Young,h);
    K(Tie,Tie) = K(Tie,Tie)+Ke;
    clear Ke;
end
upper_b_vertical_dof_1 = 2*upper_b_1;
F(upper_b_vertical_dof_1) = (f*A*10e-2)/length(upper_b_vertical_dof_1);

upper_b_vertical_dof_2 = 2*upper_b_2;
F(upper_b_vertical_dof_2) = (f*(C-1)*10e-2)/length(upper_b_vertical_dof_2);

upper_b_vertical_dof_3 = 2*upper_b_3;
F(upper_b_vertical_dof_3) = (f*(E+1)*10e-2)/length(upper_b_vertical_dof_3);


bottom_b_dof = [2*bottom_b-1 ; 2*bottom_b];
Kb = K;
Fb = F;
Kb(bottom_b_dof,:)=0;
Kb(:,bottom_b_dof)=0;
Kb(bottom_b_dof,bottom_b_dof) = eye(length(bottom_b_dof));
Fb(bottom_b_dof) = 0;

end

