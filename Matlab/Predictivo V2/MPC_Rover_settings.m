%% Script for MPC skid-Steering Rover


%% Skid-Steering State Space Rover Model
% N=16;
% r=0.2;
% L=0.61/2;  %ancho del carro
% a=0.62/2;  %Largo del carro
% ar=0.06;    %ancho rueda:
% m=58;   % mass without wheels [kg]
% Kpwm=0.1237;
% g=9.8;
% Yr=0.45;
% Yl=Yr;
% Kbr=0.0592;
% Kbl=0.0637;
% Kmr=0.0946;
% Kml=0.0770;
% xg=-0.079;
% La= 0.081;
% Ra=0.33;
% I=15;
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

Ts=60e-3;
sysd_ss=c2d(ssc_rover,Ts);

Ad=sysd_ss.a;
Bd=sysd_ss.b;
Cd=sysd_ss.c;
Dd=sysd_ss.d;
[n,p]=size(Bd);
m=size(Cd,1);

%% Augmented State Space Model [xk;uk1]

M=[Ad Bd;zeros(p,n) eye(p)];
N=[Bd;eye(p)];
Q=[Cd zeros(m,p)];


%% Optimization Parameters %%%%%%%%%%%%

Ulimite=[-100 -100;100 100];        % Input Constraints, Ulimite =[U1_min U2_min;U1_max U2_max];
Ylimite=[-pi -2;pi 2];        % Output Constraints, Ylimite=[Y1_min Y2_min;Y1_max Y2_max];
N1=50;                    % Horizonte de Prediccion
Nu=10;                     % Horizonte de Control
Rk=diag([100 100]);              % Output Weighting matrix
Qk=0.02*eye(2);            % Input Weighting matrix
r=[ones(800,1)*pi/4 [0.5*ones(400,1);1*ones(400,1)]];  %Reference trajectory
r=[r;ones(800,1)*pi/2 1*ones(800,1)];

%%%%%%%%%%%%%%%%%%%  Weighting Matrix %%%%%%%%%

Rw=[];
Qw=[];
for i=1:N1
    Rw=blkdiag(Rw,Rk);
end
for i=1:Nu
    Qw=blkdiag(Qw,Qk);
end
