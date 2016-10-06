clear all
close all
clc

load rover_auto.txt;

bat= rover_auto(:,3);
I_Der= rover_auto(:,4);
I_Iz= rover_auto(:,5);
W_Der= rover_auto(:,6);
W_Iz= rover_auto(:,7);
lat= rover_auto(:,8);
lon= rover_auto(:,9);
U_Der= rover_auto(:,11);
U_Iz= rover_auto(:,12);
Ref_Der=rover_auto(:,13);
Ref_Iz=rover_auto(:,14);
U_d_ref=rover_auto(:,15);
U_d_iz=rover_auto(:,16);
Xt= rover_auto(:,17);
estado= rover_auto(:,18);
Yaw= rover_auto(:,19);
%Velocidad=rover_auto(:,16);
tiempo = 0:60e-3:(length(bat)-1)*60e-3

figure(1)
subplot(511)
hold on 
plot(tiempo,W_Der,'r')
plot(tiempo,W_Iz,'g')
%plot(tiempo,U_Der,'--b')
%plot(tiempo,U_Iz,'--y')
legend('W_Der','W_Iz') %,'Ref_Der') %,'Ref_Iz')
ylabel('W [r/s]]')
grid on

subplot(512)
hold on
plot(tiempo,Yaw)
%plot(tiempo,estado,'y')
%plot(tiempo,Yaw_E,'r')
legend('Yaw')
ylabel('rad')
grid on

subplot(513)
plot(tiempo,U_Der,'r')
hold on
plot(tiempo,U_Iz,'g')
legend('U_Der','U_Iz')
ylabel('Control Effort')
grid on

subplot(514)
plot(tiempo,I_Der,'r')
hold on
plot(tiempo,I_Iz,'g')
legend('I_Der','I_Iz')
ylabel(' I [A]')
xlabel('Time [S]')
grid on

subplot(515)
hold on
plot(tiempo,bat,'g')
legend('Bateria')
ylabel(' Voltios')
xlabel('Time [S]')
grid on

% 
% c =0;
% for k = 2:1:length(bat)
% if (Yaw(k)-Yaw(k-1))>6;
%         c=c-2;
%     end
% if (Yaw(k)-Yaw(k-1))<-6;
%         c=c+2;
%     end
%     yaw2(k)=Yaw(k)+c*pi;
% end
% 
% if error>0
%     a = 1;
% else
%     a = 0;
