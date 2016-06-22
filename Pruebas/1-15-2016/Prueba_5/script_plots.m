tiempo = 0:60e-3:(length(Bateria)-1)*60e-3
subplot(411)
hold on
plot(tiempo,W_Der)
grid on
plot(tiempo,W_Iz,'r')
grid on
legend('Ref=6 r/s Real','Estimada')
hold off
subplot(412)
grid on
hold on
plot(tiempo,Yaw)
grid on
%plot(tiempo,I_Der_Estimado,'r')
grid on
legend('Real','Estimada')
hold off
subplot(413)
plot(tiempo,U_Der)
grid on
plot(tiempo,U_Iz,'r');
subplot(414)
plot(Velocidad);