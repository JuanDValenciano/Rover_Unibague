%% Mathematical modelling skid-steering robot 
%% Oscar Barrero M. Mayo 31 de 2016

% Parameter definition
N=16;
r=0.2;
L=0.61/2;  %ancho del carro
a=0.62/2;  %Largo del carro
ar=0.06;    %ancho rueda:
m=58;
Kpwm=0.1237;
g=9.8;
Yr=0.38;
Yl=Yr;
Kbr=0.05254;
Kbl=0.06918;
Kmr=0.032;
Kml=0.0379;
xg=0.058;
La= 0.0688;
Ra=0.278;
pw=0.184;
I=15;

wl_b=6; % cambio 
wr_b=6;

CP_bar=r*m*xg/(Yr+Yl)^2*[2*(wl_b-wr_b) 2*(wr_b-wl_b);...
                       Yr*(2*wl_b-wr_b)+Yl*wr_b Yl*(wl_b-2*wr_b)-wl_b*Yr];

MP_bar=r*[m*Yr m*Yl; -(m*xg^2+I) m*xg^2+I];
B_km=N/r*[Kml Kmr;-L*Kml L*Kmr];


A=[-inv(MP_bar)*CP_bar zeros(2,1) inv(MP_bar)*B_km;...
    -r/(Yl+Yr) r/(Yl+Yr) zeros(1,3);...
    -Kbl*N/La 0 0 -Ra/La 0;...
    0 -Kbr*N/La 0 0 -Ra/La];

B=Kpwm/La*[zeros(3,2);eye(2)];

C=[0 0 1 0 0;0.5*0.2 0.5*0.2 0 0 0];

D=zeros(2);

ssc_rover=ss(A,B,C,D);

T=60e-3;
ssd_rover=c2d(ssc_rover,T);

Ad=ssd_rover.a;
Bd=ssd_rover.b;
Cd=ssd_rover.c;
Dd=ssd_rover.d;

Ada=[Ad zeros(5,2);-Cd eye(2)];
Bda=[Bd;zeros(2)];
Cda=[Cd zeros(2)];
Dda=zeros(2,2);

Q=diag([1 1 1 1 1 3 3]);
R=diag([0.5 0.5]);

Ka=dlqr(Ada,Bda,Q,R);
K=Ka(:,1:5)
Ki=Ka(:,6:7)