close all;
clear all;
clc;

Main

%---------- Topology Matrix ----------
disp(Ttot)
%-------------------------------------

%----------  Load vector  ------------
disp('------------------ QST 2 --------------')
disp('The Load vector : ')
disp(F)
disp('------------------------------------')
%-------------------------------------

%-----  The maximum delfection -------
disp('------------------ QST 3 --------------')
disp('The maximum x displacement is : ')
max(abs(U(1:2:end)))
disp('The maximum y displacement is : ')
max(abs(U(2:2:end)))
    % Display of the contours
figure(2); clf;
colormap jet;
trisurf(Ttot,Xtot(:,1),Xtot(:,2),U(1:2:end),'edgecolor','k','facecolor','interp');
view(2);

title('Displacement (x)')
colorbar();
figure(3); clf;
colormap jet;
trisurf(Ttot,Xtot(:,1),Xtot(:,2),U(2:2:end),'edgecolor','k','facecolor','interp');
view(2);

title('Displacement (y)')
colorbar();
      %--------------------
disp('------------------------------------')
%-------------------------------------

%----------  Reaction forces  ------------
disp('------------------ QST 4 --------------')
disp('The Reaction forces are: ')
[ii,j] = find(RF>10^-10);
for i=1:length(ii)
    disp('The node : ')
    if ~rem(ii(i),2)
        Xtot(ii(i)/2,:)
        disp('RF y =  [N]')
    else 
        Xtot(0.5*(ii(i)+1),:)
        disp('RF x =  [N]')
    end
    disp(RF(ii(i)))
end

figure(4); clf;
colormap jet;
trisurf(Ttot,Xtot(:,1),Xtot(:,2),RF(1:2:end),'edgecolor','k','facecolor','interp');
view(2);

title('Reaction force (x)')
colorbar();
figure(5); clf;
colormap jet;
trisurf(Ttot,Xtot(:,1),Xtot(:,2),RF(2:2:end),'edgecolor','k','facecolor','interp');
view(2);

title('Reaction force (y)')
colorbar();


disp('------------------------------------')
%-------------------------------------

%----------  Stresses  ------------
disp('------------------ QST 5 --------------')
disp('------------------ stresses ( at nodes) contour --------------')

figure(9); clf;
for i=1:size(Ttot,1)
colormap jet
trisurf([1 2 3 4],Xtot(Ttot(i,:),1),Xtot(Ttot(i,:),2),sigma_xx(4*i-3:4*i));
view(2);
hold on
end
title('sigma (xx)');
colorbar();

figure(10); clf;
for i=1:size(Ttot,1)
colormap jet
trisurf([1 2 3 4],Xtot(Ttot(i,:),1),Xtot(Ttot(i,:),2),sigma_yy(4*i-3:4*i));
view(2);
hold on
end
title('sigma (yy)');
colorbar();

figure(11); clf;
for i=1:size(Ttot,1)
colormap jet
trisurf([1 2 3 4],Xtot(Ttot(i,:),1),Xtot(Ttot(i,:),2),sigma_xy(4*i-3:4*i));
view(2);
hold on
end
title('sigma (xy)');

disp('--------- move in 3D to see the discontinuties between elements ------------')

disp('Stresses in integrations points are not displayed but calculated in integ_sigma vectors')
disp('------------------------------------')
%-------------------------------------

%----------  Von misses Stresses  ------------
disp('------------------ QST 6 --------------')
disp('at the element with the coordinates :')
disp(Xtot(Ttot(4,:),:))
disp('the Von Mises Stress at the integration points 1, 2, 3, 4 are ')
disp(VM_sigma(4*4-3:4*4))
disp('the principal Stress xx at the integration points 1, 2, 3, 4 are ')
disp(pr_sigma_xx(4*4-3:4*4))
disp('the principal Stress yy at the integration points 1, 2, 3, 4 are ')
disp(pr_sigma_xx(4*4-3:4*4))
%-------------------------------------

[ x_coordinates,  y_coordinates] = plot_at_integ_points(Xtot,Ttot,Xgauss, VM_sigma);
hold on
z=max(VM_sigma)*ones(length(Xtot),1);
quadmesh(Ttot,Xtot(:,1),Xtot(:,2),z,0)