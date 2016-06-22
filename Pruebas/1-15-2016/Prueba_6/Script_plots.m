tiempo = 0:60e-3:(length(Bateria)-1)*60e-3
subplot(311)
hold on
plot(tiempo,W_Der)
grid on
plot(tiempo,W_Der_Estimado,'r')
grid on
legend('Ref=8 r/s Real','Estimada')
hold off
subplot(312)
grid on
hold on
plot(tiempo,I_Der)
grid on
plot(tiempo,I_Der_Estimado,'r')
grid on
legend('Real','Estimada')
hold off
subplot(313)
plot(tiempo,U_Der)
grid on
xlabel('Time [S]')
subplot(311)
ylabel('W [r/s]')
subplot(312)
ylabel('I [A]')
subplot(313)
ylabel('Control Effort')