function [ x_coordinates,  y_coordinates] = plot_at_integ_points(X,T,Xgauss, data)

t_len = size(T,1);
x_coordinates = zeros(4*t_len,1);
y_coordinates = zeros(4*t_len,1);


for i=1:t_len
    xe = X(T(i,:),:);
    a = xe(2,1) - xe(1,1);
    h = xe(4,2) - xe(1,2);

    for j =1:4
        x_coordinates(4*i-(4-j)) = 0.5*a*Xgauss(j,1) + (a/2) + xe(1,1); 
        y_coordinates(4*i-(4-j)) = 0.5*h*Xgauss(j,2) + (h/2) + xe(1,2); 
    end
    


end
[X,Y] = meshgrid(x_coordinates, y_coordinates);
Z = griddata(x_coordinates,y_coordinates,data,X,Y);
figure(12)
surf(X, Y, Z);
grid on
shading interp
view(2)
colorbar
end