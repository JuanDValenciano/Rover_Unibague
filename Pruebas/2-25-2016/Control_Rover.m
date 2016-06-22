% Control Robert 

clear,clc,close all

 

tic

%% Parámetros

L=0.61;       % Ancho del carro [m] (Distancia entre rueda y rueda)

N=16;         % Relacion de reductor de velocidad del motor

m=74.6;       % masa del rover [kg]

r=0.2;        % Radio de las llantas [m]

 

J=0.006294;

Km=0.046815;

La=0.0492930;

Ra=0.528382;

b=2.062158e-5;

Tl=6.765860e-9;

 

I=15;   %Inercia del carro

                                         %[Variables de espacio de estados]

A=[-b/J 0   Km/(N*J)    0   0   0;...        %WR

    0   -b/J 0  Km/(N*J)    0   0;...        %WL

   -Km*N/La 0 -Ra/La    0   0   0;...        %IR

   0    -Km*N/La 0  -Ra/La  0   0;...        %IL

%   r/L  -r/L  0  0  0   0; ...              %teta_carro  / Anterior

   0  0  0  0  0   1; ...                    %teta_carro

   0    0   Km*L/(2*r*I) -Km*L/(2*r*I) 0 0];     %w_carro = teta_punto                              

 

B=[0    0;...

   0    0;...

   1/La    0;...

   0    1/La;...

   0    0;...

   0    0];

 

C=[0    0   0   0   1   0;...  %teta_carro;
    r*0.5    r*0.5   0   0   0   0 ];      %Relative Linear Speed
                

 

C=eye(6);

D=zeros(6,2);

 

%% Systema Discreto

Ts=60e-3;

sys=ss(A,B,C,D,'statename',{'W_{R}' 'W_{L}' 'I_{R}' 'I_{L}' 'teta' 'teta_dot'},'inputname',{'Volt_R' 'Volt_L'});

sysd=c2d(sys,Ts);

G=sysd.a;

H=sysd.b;

Cd=sysd.c;

Dd=sysd.d;

 

%% LQR


Cd2=[0    0   0   0   1   0;...  %teta_carro;
    r*0.5    r*0.5   0   0   0   0];       %Relative Linear Speed
                

 

Q=Cd2'*Cd2;   %% Peso de variables de estado nxn

R=eye(2)*2;            %% m x n 

 

Aa=[G zeros(6,2);...
   -Cd2  eye(2)];

 

Ba=[H;[0 0;0 0;]];

 
nQ=eye(8);

nQ(7,7)=(1/(pi/90)^2);
nQ(8,8)=(1/(0.1)^2);

[K,P,E]=dlqr(Aa,Ba,nQ,R)
Kc=K(:,1:6)
Ki=K(:,7:end)

 

toc