clear all
load('Cancha_cuadrado_Prueba_error_0.1.mat')
gps=[lon lat];
pro=ell2tm(gps,'utm');
r=0.2;
V=(W_Der+W_Iz)*r/2;
T=0.06;
L=length(V);
x(1)=0;
y(1)=0;
for k=2:L
    x(k)=T*V(k)*sin(-Yaw(k))+x(k-1);
    y(k)=T*V(k)*cos(-Yaw(k))+y(k-1);
end

plot(pro(:,1)-pro(1,1),pro(:,2)-pro(1,2),'*');
hold on
plot(x,y)