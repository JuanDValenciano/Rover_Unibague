function [sys,x0,str,ts] = S_Rover_skid_steer(t,x,u,flag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Esta s-function simula un motor DC con excitacion independiente
%%%%% 
%%%%% Oscar Barreo Mendoza, Mayo 31/2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u);
       
  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%
  % Unhandled flags %
  %%%%%%%%%%%%%%%%%%%
  case { 2, 4, 9 },
    sys = [];
 
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end


%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
function [sys,x0,str,ts]=mdlInitializeSizes

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 5;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 5;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%

%x0 = [Wder0,Wiz0,theta0,W_rover0,ia_der0,ia_iz0];
% x0 = [Wiz0,Wder0,theta0,ia_iz0,ia_der0];
%x0=zeros(5,1);
x0=[0 0 0.1 0 0];
%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% end mdlInitializeSizes
%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%

function sys=mdlDerivatives(t,x,u)

%% Asignacion de variables de estado

% x= [w_r w_l theta I_l I_r]
w_l=x(1);
w_r=x(2);
theta=x(3);
I_l=x(4);
I_r=x(5);

%% Asignacion de entradas



%% Definicion de parametros

N=16;
r=0.2;
L=0.61/2;  %ancho del carro
a=0.62/2;  %Largo del carro
m=75;
Kpwm=0.1237;
g=9.8;
Yr=0.45;
Yl=Yr;
Kbr=0.064;
Kbl=0.072;
Kmr=0.2559;
Kml=0.2744;
Xg=-0.3; 
La= 0.081;
Ra=0.33;
I=24.734;
u_r=0.1;
u_l=0.8;

%% 

P=r/(Yl+Yr)*[Yr Yl;-1 1];
q_dot=P*[w_l;w_r];
x_dot=q_dot(1);
w_rover=q_dot(2);
y_dot=w_rover*Xg;

x1r_dot=x_dot-L*w_rover;
x2r_dot=x_dot+L*w_rover;
y1r_dot=y_dot+a*w_rover;
y3r_dot=y_dot-a*w_rover;
Rx=u_r*m*g/2*abs(w_rover)*(sign(x1r_dot)+sign(x2r_dot));
Fy=u_l*m*g/2*abs(w_rover)*(sign(y1r_dot)+sign(y3r_dot));
Mr=u_l*a*m*g/2*abs(w_rover)*(sign(y1r_dot)-sign(y3r_dot))+u_r*L*m*g/2*abs(w_rover)*(sign(x2r_dot)-sign(x1r_dot));


M_b=[m 0;...
     0 m*Xg^2+I];

C_b=m*Xg*w_rover*[0 1;-1 0];
R_b=[Rx*cos(theta)-Fy*sin(theta);...
     Xg*(Rx*sin(theta)+Fy*cos(theta))+Mr];
 
B_b=1/r*[1 1;-L L];

Km=N*[Kml 0;0 Kmr];

%% Dynamic matrix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A=[-inv(M_b*P)*C_b*P zeros(2,1) inv(M_b*P)*B_b*Km;...
    -r/(Yl+Yr) r/(Yl+Yr) zeros(1,3);...
    -Kbl*N/La 0 0 -Ra/La 0;...
    0 -Kbr*N/La 0 0 -Ra/La];

B=[zeros(3,2);Kpwm/La 0;0 Kpwm/La];

F=[inv(M_b*P)*R_b;zeros(3,1)];


%% Total dynamic system

sys=A*x+B*u-F;

% if t>20;
%     t
% end


% end mdlDerivatives
%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%%
function sys=mdlOutputs(t,x,u)

sys=x;