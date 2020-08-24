clear;
close all ;
home;
%------------------------
% Inputs
%------------------------
A=1;
B=4;
C=1;
D=2;
E=1;
elem=0;
k=1;
f=0;
h=0.2e-2;
Ngauss=4;
gamma=0;
heat_conduction = 237;
Area = h*10e-2;
alpha = heat_conduction * Area;
%------------------------------

%--------------------------------
% Mesh
[X, T, btot, upper_b, upper_b_1, upper_b_2, upper_b_3, bottom_b, left_b, right_b] = mesh(A,B,C,D,E);

% Solution
[Kb,Fb,U] = MEF2D(f,elem,k,X,T,left_b,right_b,Ngauss,gamma,alpha);
%------------------------------
% Display
% 
figure(1); clf;
colormap hsv;
if elem==0 && k==2
    T=T(:,[1 2 3 6 9 8 7 4]);
end
trisurf(T,X(:,1),X(:,2),0*X(:,1),U,'edgecolor','k','facecolor','interp');
title('Temperature field [K]')
view(2), axis equal,colorbar;

[flux_x, flux_y] = flux(heat_conduction , T,U);

figure(2); clf;
z=-ones(length(X),1);
c=z;
quadmesh(T,X(:,1),X(:,2),z)
hold on
for i=1:length(T)
        a = [flux_x(4*i-3) flux_y(4*i-3)];
        b = [flux_x(4*i-2) flux_y(4*i-2)];
        c = [flux_x(4*i-1) flux_y(4*i-1)];
        d = [flux_x(4*i)   flux_y(4*i)];
        
        quiver(X(T(i,:),1),X(T(i,:),2),flux_x(4*i-3:4*i),flux_y(4*i-3:4*i));
hold on
end
view(2)
title('Heat flux')
hold off

%------------------Temperature at the edges--------------
disp('------------------ Temperature at the right edge ------------')
disp(U(right_b))
disp('respectively at the nodes of coordinates :')
disp(X(right_b,:))
disp('------------------ Temperature at the left edge ------------')
disp(U(left_b))
disp('respectively at the nodes of coordinates :')
disp(X(left_b,:))
disp('------------------------------------------------------------------------------------')
disp('------------------------------------------------------------------------------------')
disp('------------------ Heat flux (X component) at the right edge ------------')
for i=1:length(right_b)
elements_to_display=find(any(T==right_b(i),2));
fr=T(elements_to_display,:)==right_b(i);
node_number=zeros(size(fr,1),1);
for j=1:size(fr,1)
node_number(j)=find(fr(j,:));
disp('The X component of the flux is : [W/m²]')
disp(flux_x(4*elements_to_display(j)-(4-node_number(j))))
disp('at the node   :')
disp(X(T(elements_to_display(j),node_number(j)),:))
disp('(calculated in the element)')
disp(X(T(elements_to_display(j),:),:))
end
end
disp('--------------------------------------------------------------------------')
disp('------------------ Heat flux (Y component) at the right edge ------------')
for i=1:length(right_b)
elements_to_display=find(any(T==right_b(i),2));
fr=T(elements_to_display,:)==right_b(i);
node_number=zeros(size(fr,1),1);
for j=1:size(fr,1)
node_number(j)=find(fr(j,:));
disp('The Y component of the flux is : [W/m²]')
disp(flux_y(4*elements_to_display(j)-(4-node_number(j))))
disp('at the node   :')
disp(X(T(elements_to_display(j),node_number(j)),:))
disp('(calculated in the element)')
disp(X(T(elements_to_display(j),:),:))
end
end
disp('--------------------------------------------------------------------------')
disp('--------------------------------------------------------------------------')
disp('------------------ Heat flux (X component) at the left edge ------------')
for i=1:length(left_b)
elements_to_display=find(any(T==left_b(i),2));
fr=T(elements_to_display,:)==left_b(i);
node_number=zeros(size(fr,1),1);
for j=1:size(fr,1)
node_number(j)=find(fr(j,:));
disp('The X component of the flux is : [W/m²]')
disp(flux_x(4*elements_to_display(j)-(4-node_number(j))))
disp('at the node   :')
disp(X(T(elements_to_display(j),node_number(j)),:))
disp('(calculated in the element)')
disp(X(T(elements_to_display(j),:),:))
end
end

disp('------------------ Heat flux (Y component) at the left edge ------------')
for i=1:length(left_b)
elements_to_display=find(any(T==left_b(i),2));
fr=T(elements_to_display,:)==left_b(i);
node_number=zeros(size(fr,1),1);
for j=1:size(fr,1)
node_number(j)=find(fr(j,:));
disp('The Y component of the flux is : [W/m²]')
disp(flux_y(4*elements_to_display(j)-(4-node_number(j))))
disp('at the node   :')
disp(X(T(elements_to_display(j),node_number(j)),:))
disp('(calculated in the element)')
disp(X(T(elements_to_display(j),:),:))
end
end
disp('--------------------------------------------------------------------------')
disp('--------------------------------------------------------------------------')