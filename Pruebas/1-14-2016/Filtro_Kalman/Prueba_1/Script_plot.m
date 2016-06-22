tiempo = 0:60e-3:(length(Bateria)-1)*60e-3
subplot(511)
plot(tiempo,W_Der)
grid on 
subplot(512)
grid on
plot(tiempo,W_Der_Estimado)
grid on
subplot(513)
plot(tiempo,I_Der)
grid on
subplot(514)
plot(tiempo,I_Der_Estimado)
grid on
subplot(515)
plot(tiempo,U_Der)
grid on

xlabel('Time [S]')
subplot(511)
ylabel('W [r/s]')
subplot(512)
ylabel('W [r/s]')
subplot(513)
ylabel('I [A]')
subplot(514)
ylabel('I [A]')
subplot(515)
ylabel('Control Effort')