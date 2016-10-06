Ts=60e-3;

Fs=1/Ts;

t1=100;

t = 0:Ts:t1;

f0=0;

f1=0.8;

y = chirp(t,0,t1,f1)*100;

%plot(t,y)
p = zeros(1,10);

y=[y p]

plot(y)