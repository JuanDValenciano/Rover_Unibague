subplot(311)
tiempo = 0:60e-3:(length(Bateria)-1)*60e-3
plot(tiempo,W_Der)
grid on 
legend('Ref = 8 rad/seg')
subplot(312)
grid on
plot(tiempo,I_Der)
grid on
subplot(313)
plot(tiempo,U_Der)
grid on
xlabel('Time')
xlabel('Time [S]')
subplot(311)
ylabel('W [r/s]')
subplot(312)
ylabel('I [A]')
subplot(313)
ylabel('Control Effort')
