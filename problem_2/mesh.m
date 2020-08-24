function [Xtot, Ttot, btot, upper_b, upper_b_1, upper_b_2, upper_b_3, bottom_b, left_b, right_b] = mesh(A,B,C,D,E)
%-----------------
%returns a matrix Xtot of nodes' coordinates, Ttot for the rectangles
%indexes in the X matrix, and 5 vectors b for the borders' index in the X matrix
%and plots also the mesh
%-----------------
[X,T,b] = Meshing2dQ(0,A*10e-2,B*10e-2,(B+1)*10e-2,A+1,2,1);
[X2,T2,b2] = Meshing2dQ((A-1)*10e-2,(A)*10e-2,0,(B)*10e-2,2,B+1,1);
[X3,T3,b3] = Meshing2dQ((A)*10e-2,(A+C)*10e-2,0,10e-2,C+1,2,1);
[X4,T4,b4] = Meshing2dQ((A+C-1)*10e-2,(A+C)*10e-2,10e-2,(D+1)*10e-2,2,D+1,1);
[X5,T5,b5] = Meshing2dQ((A+C)*10e-2,(A+C+E)*10e-2,D*10e-2,(D+1)*10e-2,E+1,2,1);
remp_X2=X2;
remp_T2=T2;
remp_b2=b2;
count = 0;
for i=1:length(X2)
    for j=1:length(X)
        if all(X2(i,:)==X(j,:))
            remp_X2(i-count,:)=[];
            remp_T2(T2==i)=j-length(X);
            remp_b2(b2==i)=j-length(X);
            count = count +1;
        end
    end
end
X2 = remp_X2;
T2=remp_T2;
b2=remp_b2;
remp_X3 = X3;
remp_T3=T3;
remp_b3=b3;
count =0;
for i=1:length(X3)
    for j=1:length(X2)
        if all(X3(i,:)==X2(j,:))
            remp_X3(i-count,:)=[];
            remp_T3(T3==i)=j-length(X2);
            remp_T3(T3>i) = remp_T3(T3>i) - 1;
            remp_b3(b3==i)=j-length(X2);
            remp_b3(b3>i) = remp_b3(b3>i) - 1;
            count = count +1;
        end
    end
end
X3 = remp_X3;
T3 = remp_T3;
b3 = remp_b3;
remp_X4 = X4;
remp_T4 = T4;
remp_b4=b4;
count =0;
for i=1:length(X4)
    for j=1:length(X3)
        if all(X4(i,:)==X3(j,:))
            remp_X4(i-count,:)=[];
            remp_T4(T4==i)=j-length(X3);
            remp_T4(T4>i) = remp_T4(T4>i) - 1;
            remp_b4(b4==i)=j-length(X3);
            remp_b4(b4>i) = remp_b4(b4>i) - 1;
            count = count +1;
        end
    end
end
X4 = remp_X4;
T4=remp_T4;
b4 = remp_b4;
remp_X5=X5;
remp_T5=T5;
remp_b5=b5;
count = 0;
for i=1:length(X5)
    for j=1:length(X4)
        if all(X5(i,:)==X4(j,:))
            remp_X5(i-count,:)=[];
            remp_T5(T5==i)=j-length(X4);
            remp_T5(T5>i) = remp_T5(T5>i) - 1 ;
            remp_b5(b5==i)=j-length(X4);
            remp_b5(b5>i) = remp_b5(b5>i) - 1 ;
            count = count +1;
        end
    end
end
X5=remp_X5;
T5=remp_T5;
b5=remp_b5;
Xtot=[X;X2;X3;X4;X5];
Ttot=[T;T2+length(X);T3+(length(X)+length(X2));T4+(length(X)+length(X2)+length(X3));T5+(length(X)+length(X2)+length(X3)+length(X4))];

[u,I,~] = unique(Xtot, 'rows', 'first');
ixDupRows = setdiff(1:size(Xtot,1), I);
dupRowValues = Xtot(ixDupRows,:);
remp_Ttot=Ttot;
remp_Xtot=Xtot;
count =0;
for j=1:length(dupRowValues)
for i=1:length(Xtot)
if all(dupRowValues(j,:)==Xtot(i,:))
remp_Xtot(ixDupRows(j)-count,:)=[];
remp_Ttot(Ttot==ixDupRows(j))=i;
remp_Ttot(Ttot>ixDupRows(j)) = remp_Ttot(Ttot>ixDupRows(j)) - 1;
count=count+1;
break;
end
end
end

Xtot=remp_Xtot;
Ttot=remp_Ttot;
btot = [b b2+length(X) b3+(length(X)+length(X2)) b4+(length(X)+length(X2)+length(X3)) b5+(length(X)+length(X2)+length(X3)+length(X4))];
bottom_b=find(~Xtot(:,2));
upper_b=find(~((Xtot(:,2)-(B+1)*10e-2).*(Xtot(:,2)-10e-2)));
upper_b_1=[];
upper_b_2=[];
upper_b_3=[];
for i=1:length(upper_b)
    if Xtot(upper_b(i),2)==10e-2
        upper_b_2=[upper_b_2 upper_b(i)];
    else 
        if Xtot(upper_b(i),1)< (A+C-1)*10e-2
            upper_b_1 = [upper_b_1 upper_b(i)];
        else
            upper_b_3 = [upper_b_3 upper_b(i)];
        end
    end
end
z=ones(length(Xtot),1);
c=z;
figure(1);
quadmesh(Ttot,Xtot(:,1),Xtot(:,2),z)
left_b=find(~(Xtot(:,1)));
right_b=find(~((Xtot(:,1)-(A+C+E)*10e-2)));


end
