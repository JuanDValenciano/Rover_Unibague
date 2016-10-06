function [sys,x0,str,ts] = S_Rover_motores(t,x,u,flag,Km_r,J_r,La_r,b_r)
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
    sys=mdlDerivatives(t,x,u,flag,Km_r,J_r,La_r,b_r);
       
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

sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0; %%  SI salidas dependes de (u)
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0 = [0 0];


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

function sys=mdlDerivatives(t,x,u,flag,Km_r,J_r,La_r,b_r)

%% Asignacion de variables de estado

wr=x(1);          % velocidad angular motor derecho  [rad/s]
ir=x(2);




%% Asignacion de entradas

 Vr=u(1);        % Voltaje de armadura motor derecho [V]


%% Definicion de parametros
% 
% b=1e-3;     % coeficiente de fricci√≥n viscosa
% Km=1;       % Constante del motor
% J=0.1;      % Momento de inercia del eje del motor
% La=100e-3   % Inductancia de armadura del motor
Ra=0.4;     % Resistencia de armadura del motor
r=0.2;      % radio de las ruedas del carro
L=0.61;       % Ancho del carro
N=16;       % Relacion de reductor de velocidad del motor
m=74.6;       % masa del rover [kg]

%% Parametros de vacio
%Km_r =0.0360;
%J_r =7.4379e-4;
%La_r =0.1060;
%Ra_r =0.5;
%b_r =9.9389e-04;
%b_l =9.9389e-04;
%Km_l =0.0286;
%J_l =9.0010e-04;
%La_l =0.1087;
%Ra_l =0.6651;

%% Par·metros de carga
Ja =1.5212;
ba =0.5870;
Fa =0.0017;
bal =2.1797e-04;
bar =8.2701e-07;
%Tl_r =0.003*7;
%Tl_l =1.7129e-06;

%% Definicion ecuaciones diferenciales

sys(1)= -b_r/J_r*(wr*N) + Km_r/(J_r)*ir/N ;
sys(2)= -Km_r/La_r*(wr*N)  + -Ra/La_r*ir +1/La_r*Vr;


% end mdlDerivatives
%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%%
function sys=mdlOutputs(t,x,u)

%%
sys=x(1:2);