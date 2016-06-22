
clear all
close all
clc

load rover_auto_Lab_1.txt;

bat= rover_auto_Lab_1(:,3);
I_Der= rover_auto_Lab_1(:,4);
I_Iz= rover_auto_Lab_1(:,5);
W_Der= rover_auto_Lab_1(:,6);
W_Iz= rover_auto_Lab_1(:,7);
U_Der= rover_auto_Lab_1(:,9);
U_Iz= rover_auto_Lab_1(:,10);
Yaw= rover_auto_Lab_1(:,17);
%Velocidad=rover_auto(:,18);
tiempo = 0:60e-3:(length(bat)-1)*60e-3

figure(1)
subplot(411)
%plot(tiempo,(W_Iz+W_Der)*0.2/2)
hold on
plot(tiempo,W_Der,'r')
plot(tiempo,W_Iz,'g')
legend('W_Der','W_Iz')
ylabel('W [r/s]]')
grid on

subplot(412)
plot(tiempo,Yaw)
legend('Yaw')
ylabel('rad')
grid on

subplot(413)
plot(tiempo,U_Der,'r')
hold on
plot(tiempo,U_Iz,'g')
legend('U_Der','U_Iz')
ylabel('Control Effort')
grid on

subplot(414)
plot(tiempo,I_Der,'r')
hold on
plot(tiempo,I_Iz,'g')
legend('I_Der','I_Iz')
ylabel(' I [A]')
xlabel('Time [S]')
grid on