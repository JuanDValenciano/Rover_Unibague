clear all
close all
clc

load rover_auto.txt;

bat= rover_auto(:,3);
I_Der= rover_auto(:,4);
I_Iz= rover_auto(:,5);
W_Der= rover_auto(:,6);
W_Iz= rover_auto(:,7);
U_Der= rover_auto(:,9);
U_Iz= rover_auto(:,10);
I_Der_E=rover_auto(:,11);
I_Iz_E=rover_auto(:,12);
Yaw_E=rover_auto(:,13);
V_Yaw= rover_auto(:,14);
V_Yaw_R= rover_auto(:,15);
Yaw= rover_auto(:,17);
Velocidad=rover_auto(:,16);
tiempo = 0:60e-3:(length(bat)-1)*60e-3

figure(1)
subplot(411)

hold on
plot(tiempo,W_Der,'r')
%%plot(tiempo,W_Der_E,'g')
plot(tiempo,Velocidad)
legend('W_Der','W_Iz','Vel')
ylabel('W [r/s]]')
grid on

subplot(412)
hold on
plot(tiempo,Yaw)
plot(tiempo,Yaw_E,'r')
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
plot(tiempo,I_Der_E,'g')
legend('I_Der','I_Iz')
ylabel(' I [A]')
xlabel('Time [S]')
grid on

figure(2)
subplot(211)
plot(tiempo,V_Yaw,'r')
legend('V_Yaw')
ylabel('Rad')
xlabel('Time [S]')
grid on

subplot(212)
plot(tiempo,Yaw)
legend('Yaw')
ylabel('rad')
grid on

figure
hold on
grid on 
plot(diff(Yaw)/0.06)
plot(V_Yaw,'r')
plot(V_Yaw_R,'g')

