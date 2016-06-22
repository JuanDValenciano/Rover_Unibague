subplot(311)
tiempo = 0:60e-3:(length(Bateria)-1)*60e-3
plot(tiempo,W_Der)
grid on 
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
figure

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

xlabel('Time [S]')
subplot(411)
ylabel('W [r/s]')
subplot(412)
ylabel('I [A]')
subplot(413)
ylabel('I [A]')
subplot(414)
ylabel('Control Effort')




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
