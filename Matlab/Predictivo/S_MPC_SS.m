function [sys,x0,str,ts] = S_MPC_SS(t,x,u,flag,Q,M,N,N1,Nu,Rw,Qw,r)
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
% 
%   %%%%%%%%%%%%%%%
%   % Derivatives %
%   %%%%%%%%%%%%%%%
%   case 1,
%     sys=mdlDerivatives(t,x,u);
%        
  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u,Q,M,N,N1,Nu,Rw,Qw,r);

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

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 7;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

x0=[];
%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0.06 0];

% end mdlInitializeSizes
%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
%%
function sys=mdlOutputs(t,x,u,Q,M,N,N1,Nu,Rw,Qw,r)


k=ceil(t/0.06)+1;
if k<2
    u=zeros(7,1);
end
uk1=u(1:2);
%r=[u(3)*ones(N1,1) u(4)*ones(N1,1)];
xk=u(3:7);

%% MPC state space solution

p=2;          % Number of Inputs
m=2;		% Number of Outputs
r_vec=reshape(r(k+1:k+N1,:)',N1*m,1);   % Reference trajectories in vector format
Zk=[xk;uk1];           % Augmented State Space Vector

%%  Free and Force Response Matrices Calculation %%%%%%%%%%%%%%%

F=[];
[m,n]=size(Q);     
MN2=eye(n);
for i=1:N1
    MN2=MN2*M;
    F=[F;Q*MN2];
end
H=[];
for i=1:Nu
    H=[H [zeros((i-1)*m,n);Q;F(1:end-i*m,:)]*N];
end

Ku=inv(H'*Rw*H+Qw)*H'*Rw;      
Duk=Ku(1:p,:)*(r_vec-F*Zk);    % Increment control input calculation

if k<1
    sys=Duk;
else
    sys=uk1+Duk;
end

