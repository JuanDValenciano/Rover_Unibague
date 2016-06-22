clc,close all

N=16;
I_Der_mean =[0 2.28 7.52 14.66 20.63 24.41 25.49 25.69 25.5 25.8 27.11 26.75 27.15 27.47 27.88 28.38 23.78 15.8 7.9 2.31 0 -1.92 -8.13 -14.19 -20.33 -30.26 -32.79 -36.63 -31.09 -31.38 -30.52 -28.93 -29.64 -31.03 -31.32 -31.26 -23.83 -16.93 -9.14 -2.68 0];
W_Der_mean =[0 0 0 0 0 1.08 2.45 3.58 4.72 5.44 7.35 6.01 4.17 3.2 2 0.72 0.1 0 0 0 0 0 0 0 0 0 -1.29 -2.48 -3.9 -5.1 -6.7 -5.55 -4.29 -3.25 -1.07 -0.37 0 0 0 0 0]*N;
U_Der_mean =[0 10 20 30 40 50 60 70 80 90 100 90 80 70 60 50 40 30 20 10 0 -10 -20 -30 -40 -50 -60 -70 -80 -90 -100 -90 -80 -70 -60 -50 -40 -30 -20 -10 0];

R=0.4;
V=11;

subplot(211)

x_s=V*U_Der_mean(6:11)/100 - R*I_Der_mean(6:11);
y_s=W_Der_mean(6:11);
plot(x_s,y_s,'*')

c_s=polyfit(x_s,y_s,1);

K_s=1/c_s(1)


xlabel('(V - R*i )/K')
ylabel('w [rad/s]')
grid on

hold on
plot(x_s,x_s*c_s(1)+c_s(2),'r')


x_b=V*U_Der_mean(11:16)/100 - R*I_Der_mean(11:16);
y_b=W_Der_mean(11:16);

plot(x_b,y_b,'bo')
c_b=polyfit(x_b,y_b,1);
plot(x_b,x_b*c_b(1)+c_b(2),'r')
K_b=1/c_b(1)

K=(K_b+K_s)/2

legend('Real Data UP','Linear aprox. Up','Real Data Down','Linear Aprox. Down')

subplot(212)

x_s=K*I_Der_mean(6:11)/N;
y_s=W_Der_mean(6:11); 

plot(x_s,y_s,'*')
c_s=polyfit(x_s,y_s,1);
b_s=1/c_s(1)

grid on

hold on
plot(x_s,x_s*c_s(1)+c_s(2),'r')

x_b=K*I_Der_mean(11:16)/N;
y_b=W_Der_mean(11:16); 

plot(x_b,y_b,'bo')
c_b=polyfit(x_b,y_b,1);
plot(x_b,x_b*c_b(1)+c_b(2),'r')
b_b=1/c_b(1)

b=(b_b+b_s)/2

legend('Real Data UP','Linear aprox. Up','Real Data Down','Linear Aprox. Down')
