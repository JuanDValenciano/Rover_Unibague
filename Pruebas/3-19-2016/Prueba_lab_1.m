clear all
close all
clc

load rover_rc.txt;

bat= rover_rc(:,3);
I_Der= rover_rc(:,4);
I_Iz= rover_rc(:,5);
W_Der= rover_rc(:,6);
W_Iz= rover_rc(:,7);
%U_Der= rover_auto(:,1);
%U_Iz= rover_auto(:,2);
lon= rover_rc(:,8);
lat= rover_rc(:,9);
estado =  rover_rc(:,10);
U_Der= rover_rc(:,11);
U_Iz= rover_rc(:,12);
Ref_Der= rover_rc(:,13);
Ref_Iz= rover_rc(:,14);
Ir_Der= rover_rc(:,15);
Ir_Iz= rover_rc(:,16);
Yaw=rover_rc(:,19);

tiempo = 0:60e-3:(length(bat)-1)*60e-3

figure(1)
subplot(411)

hold on
plot(tiempo,W_Der,'r')
plot(tiempo,W_Iz,'g')
plot(tiempo,Ref_Der,'m')
plot(tiempo,Ref_Iz)

legend('W_Der','W_Iz','Vel')
ylabel('W [r/s]]')
grid on

subplot(412)
plot(tiempo,U_Der,'r')
hold on
plot(tiempo,U_Iz,'g')
legend('U_Der','U_Iz')
ylabel('Control Effort')
grid on

subplot(413)
hold on
plot(tiempo,I_Der,'r')
plot(tiempo,I_Iz,'g')
plot(tiempo,Ir_Der,'y')
plot(tiempo,Ir_Iz,'m')
legend('I_Der','I_Iz','Kal_Der','Kal_Iz')
ylabel(' I [A]')
grid on

subplot(414)
hold on
plot(tiempo,Yaw);
ylabel(' Rad');
grid on


