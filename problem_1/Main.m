close all;
clear all;
clc;
A=1;
B=4;
C=1;
D=2;
E=1;
f = 0.5 * 100 ;
Young=2e11;
nu=0.3;
h=0.2e-2;
[Xgauss,Wgauss]=Quadrature(0, 4); 

[Xtot, Ttot, btot, upper_b, upper_b_1, upper_b_2, upper_b_3, bottom_b] = mesh(A,B,C,D,E);

[ Kb,Fb,K, F] = Assembly(0,1,Xtot,Ttot,upper_b_1,upper_b_2,upper_b_3,bottom_b,f,nu,Young,h,Xgauss,Wgauss,4,A,B,C,D,E);
U = Kb\Fb;
RF = -K*U;

upper_b_vertical_dof_1 = 2*upper_b_1;
RF([upper_b_vertical_dof_1 upper_b_vertical_dof_1-1]) = 0;

upper_b_vertical_dof_2 = 2*upper_b_2;
RF([upper_b_vertical_dof_2 upper_b_vertical_dof_2-1]) = 0;

upper_b_vertical_dof_3 = 2*upper_b_3;
RF([upper_b_vertical_dof_3 upper_b_vertical_dof_3-1]) = 0;





[eps_xx, eps_yy, eps_xy] = strain(Ttot,U);

%figure(6); clf;
%for i=1:size(Ttot,1)
%trisurf([1 2 3 4],Xtot(Ttot(i,:),1),Xtot(Ttot(i,:),2),eps_xx(4*i-3:4*i));
%view(2);
%hold on
%end
%title('eps (xx)');
%colorbar();

%figure(7); clf;
%for i=1:size(Ttot,1)
%trisurf([1 2 3 4],Xtot(Ttot(i,:),1),Xtot(Ttot(i,:),2),eps_yy(4*i-3:4*i));
%view(2);
%hold on
%end
%title('eps (yy)');
%colorbar();

%figure(8); clf;
%for i=1:size(Ttot,1)
%trisurf([1 2 3 4],Xtot(Ttot(i,:),1),Xtot(Ttot(i,:),2),eps_xy(4*i-3:4*i));
%view(2);
%hold on
%end
%title('eps (xy)');
%colorbar();


[sigma_xx, sigma_yy, sigma_xy] = stress(Ttot,eps_xx,eps_yy,eps_xy,Young,nu);


[integ_eps_xx, integ_eps_yy, integ_eps_xy] = integ_strain(Ttot,U,Xgauss);
[integ_sigma_xx, integ_sigma_yy, integ_sigma_xy] = integ_stress(Ttot,integ_eps_xx,integ_eps_yy,integ_eps_xy,Young,nu);
[VM_sigma] = VMstress(integ_sigma_xx,integ_sigma_yy,integ_sigma_xy);
[pr_sigma_xx, pr_sigma_yy] = principal_stress(Ttot, integ_sigma_xx,integ_sigma_yy,integ_sigma_xy);