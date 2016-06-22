clear all
close all
clc

load rover_auto.txt;

bat= rover_auto(:,3);
I_Der=rover_auto(:,4);
I_Iz=rover_auto(:,5);
W_Iz=rover_auto(:,6);
W_Der=rover_auto(:,7);
U_Der=rover_auto(:,11);
U_Iz=rover_auto(:,12);
Yaw=rover_auto(:,19);
Velocidad=rover_auto(:,18);
tiempo = 0:60e-3:(length(bat)-1)*60e-3

figure(1)
subplot(411)
%plot(tiempo,(W_Iz+W_Der)*0.2/2)
hold on
plot(tiempo,W_Der,'r')
plot(tiempo,W_Iz,'g')
plot(tiempo,Velocidad,'m')
legend('Velocidad m/s','W_Der','W_Iz')
ylabel('W [r/s]]')
grid on

subplot(412)
plot(tiempo,Yaw*(180/pi))
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
ylabel(' I [A]')
xlabel('Time [S]')