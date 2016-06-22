clear all
close all
clc

load rover_rc.txt;

bat= rover_rc(:,3);
I_Der= rover_rc(:,4);
I_Iz= rover_rc(:,5);
W_Der= rover_rc(:,6);
W_Iz= rover_rc(:,7);
U_Der= rover_rc(:,1);
U_Iz= rover_rc(:,2);

tiempo = 0:60e-3:(length(bat)-1)*60e-3

figure(1)
subplot(311)

hold on
plot(tiempo,W_Der,'r')
plot(tiempo,W_Iz,'g')
legend('W_Der','W_Iz','Vel')
ylabel('W [r/s]]')
grid on

subplot(312)
plot(tiempo,U_Der,'r')
hold on
plot(tiempo,U_Iz,'g')
legend('U_Der','U_Iz')
ylabel('Control Effort')
grid on

subplot(313)
hold on
plot(tiempo,I_Der,'r')
plot(tiempo,I_Iz,'g')
legend('I_Der','I_Iz')
ylabel(' I [A]')
grid on



