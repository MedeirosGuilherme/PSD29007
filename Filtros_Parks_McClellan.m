clc
clear all
close all

fs = 8000;
dev = [0.01 0.01];

f = [1000 1500]
a = [1 0];

[n,f0,a0,w] = firpmord(f,a,dev,fs);
order = 17;

b = firpm(n, f0, a0);

[h,w] = freqz(b, 1, 512);
plot(w/pi,20*log10(abs(h)));
legend('Ideal','firpm Design');
xlabel('Radian Frequency(omega/pi');
ylabel ('magnitude');

