function [X,T,b] = Meshing2dQ(x1,x2,y1,y2,npx,npy,ke)
% Rectangular mesh for a rectangle plate
%
% Inputs:    
%   x1,x2,y1,y2:    corners' coordinates
%   npx,npy:        Nodes number in each direction 
% Sorties:   
%          X:  coordinates table
%          T:  rectangular idnexes table
%          b:  border nodes
if(ke==1)
X = zeros((npx)*(npy),2);
% Number of elements in each direction
nx = npx-1; ny = npy-1;
%
hx = (x2-x1)/nx;
hy = (y2-y1)/ny;
xs = linspace(x1,x2,npx)'; 
unos = ones(npx,1);
%
% Coordonnées des noeuds
%
yys = linspace(y1,y2,npy);
for i=1:npy
    ys = yys(i)*unos; 
    posi = (i-1)*(npx)+1:i*(npx); 
    X(posi,:)=[xs,ys];
end
% P1
% Connectivité
T = zeros(nx*ny,4);
        for i=1:ny
            for j=1:nx
                ielem = (i-1)*nx+j;
                inode = (i-1)*(npx)+j;
                T(ielem,:) = [inode   inode+1 inode+npx+1 inode+(npx) ];
            end   
        end
%Noeuds sur le bord stockées dans "b" comme suit (bas,gauche,droite,haut)
b=[1:npx,npx+1:npx:npx*npy,2*npx:npx:npx*npy,npx*npy-npx+2:npx*npy-1];
%-----------------------affichage Q1--------------
% figure(1);
% for i=1:size(T,1)
%     for k=1:4
%     plot(X(T(i,k),1),X(T(i,k),2),'r.', 'MarkerSize',10);hold on;
%     textString = sprintf('n%d',T(i,k));
%     text(X(T(i,k),1),X(T(i,k),2), textString, 'FontSize', 10);
%     if(k==4)
%         x=[X(T(i,4),1),X(T(i,1),1)];
%         y=[X(T(i,4),2),X(T(i,1),2)];
%         plot(x,y,'b');
%     else
%         x=[X(T(i,k),1),X(T(i,k+1),1)];
%         y=[X(T(i,k),2),X(T(i,k+1),2)];
%         plot(x,y,'b');
%     end
%     end
% xe=1/2*(X(T(i,3),1)+X(T(i,4),1));
% ye=1/2*(X(T(i,1),2)+X(T(i,3),2));
% text(xe, ye, sprintf('e%d', i), 'color', 'red');
% end
%-------------------------------------------------------------
elseif(ke==2)
  X = zeros(2*(npx-1)*2*(npy-1),2);
% Nombre des éléments dans chaque direction
nx = npx-1; ny = npy-1;
%
hx = (x2-x1)/nx;
hy = (y2-y1)/ny;
xs = linspace(x1,x2,2*npx-1)'; 
unos = ones(2*npx-1,1);
%
% Coordonnées des noeuds
%
yys = linspace(y1,y2,2*npy-1);
for i=1:2*npy-1
    ys = yys(i)*unos; 
    posi = (i-1)*(2*npx-1)+1:i*(2*npx-1); 
    X(posi,:)=[xs,ys];
end
% P1
% Connectivité
T = zeros(nx*ny,9);
        for i=1:ny
            for j=1:nx
                ielem = (i-1)*nx+j;
                inode = 2*(i-1)*(2*npx-1)+2*j-1;
% %  T(ielem,:) = [inode   inode+1 inode+2 inode+2*npx+1 inode+4*npx inode+4*npx-1 inode+4*npx-2 inode+2*npx-1  inode+2*npx ];
     T(ielem,:) =[inode inode+2 inode+4*npx inode+4*npx-2 inode+1 inode+2*npx+1 inode+4*npx-1 inode+2*npx-1  inode+2*npx ];
%         T(ielem,:) = [inode+4*npx inode+4*npx-2  inode  inode+2  inode+2*npx+1 inode+4*npx-1 inode+2*npx-1 inode+1 inode+2*npx];
            end   
        end
%Noeuds sur le bord stockées dans "b" comme suit (bas,gauche,droite,haut)
b=[1:2*npx-1,2*npx:2*npx-1:(2*npx-1)*(2*npy-1),2*(2*npx-1):2*npx-1:(2*npx-1)*(2*npy-1),(2*npx-1)*(2*npy-1)-(2*npx-1)+2:(2*npx-1)*(2*npy-1)-1];  
%--------------------------affichage Q2---------------------------------------
% figure(1);
% for i=1:size(T,1)
%     for k=1:4
%     plot(X(T(i,k),1),X(T(i,k),2),'r.', 'MarkerSize',10);hold on;
%     textString = sprintf('n%d',T(i,k));
%     text(X(T(i,k),1),X(T(i,k),2), textString, 'FontSize', 10);
%     if(k==4)
%         x=[X(T(i,4),1),X(T(i,1),1)];
%         y=[X(T(i,4),2),X(T(i,1),2)];
%         plot(x,y,'b');
%     else
%         x=[X(T(i,k),1),X(T(i,k+1),1)];
%         y=[X(T(i,k),2),X(T(i,k+1),2)];
%         plot(x,y,'b');
%     end
%     end
%     for h=5:9
%        plot(X(T(i,h),1),X(T(i,h),2),'r.', 'MarkerSize',10);hold on;
%        textString = sprintf('n%d',T(i,h));
%        text(X(T(i,h),1),X(T(i,h),2), textString, 'FontSize', 10); 
%     end
% xe=1/2*(X(T(i,3),1)+X(T(i,4),1));
% ye=1/2*(X(T(i,1),2)+X(T(i,3),2));
% text(xe, ye, sprintf('e%d', i), 'color', 'red');
% end
%----------------------------------------------------------------
elseif (ke==3)
X = zeros((3*npx-2)*(3*npy-2),2);
% Nombre des éléments dans chaque direction
nx = npx-1; ny = npy-1;
%
hx = (x2-x1)/nx;
hy = (y2-y1)/ny;
xs = linspace(x1,x2,3*npx-2)'; 
unos = ones(3*npx-2,1);
%
% Coordonnées des noeuds
%
yys = linspace(y1,y2,3*npy-2);
for i=1:3*npy-2
    ys = yys(i)*unos; 
    posi = (i-1)*(3*npx-2)+1:i*(3*npx-2); 
    X(posi,:)=[xs,ys];
end
% P1
% Connectivité
T = zeros(nx*ny,16);
        for i=1:ny
            for j=1:nx
                ielem = (i-1)*nx+j;
                inode = 3*(i-1)*(3*npx-2)+3*j-2;
%                 T(ielem,:) = [inode   inode+1 inode+2 inode+2*npx+1 inode+4*npx inode+4*npx-1 inode+4*npx-2 inode+2*npx-1  inode+2*npx ];
                T(ielem,:) = [inode inode+3 inode-3+9*npx inode-6+9*npx inode+1 inode+2 inode+3*npx+1 inode+6*npx-1 inode-4+9*npx inode-5+9*npx inode+6*npx-4 inode+3*npx-2 inode+3*npx-1 inode+3*npx inode+6*npx-2 inode+6*npx-3];
            end   
        end
%Noeuds sur le bord stockées dans "b" comme suit (bas,gauche,droite,haut)
% b=[1:2*npx-1,2*npx:2*npx-1:(2*npx-1)*(2*npy-1),2*(2*npx-1):2*npx-1:(2*npx-1)*(2*npy-1),(2*npx-1)*(2*npy-1)-(2*npx-1)+2:(2*npx-1)*(2*npy-1)-1];
b=zeros(size(X,1)-(3*npx-4)*(3*npy-4),1)';
h=1;
for i=1:size(X,1)
    if(X(i,1)==x1 || X(i,2)==y1 || X(i,1)== x2 || X(i,2)== y2)
        b(h)=i;
        h=h+1;
    end
end
else
    disp('Not yet available ');
end
% affichageMaillage(X,T,b,0,k);
end   


