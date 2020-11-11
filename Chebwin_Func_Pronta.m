clc
clear all
close all

fsamp = 8000;
fcuts =[1000 1500];
mags = [1 0];
devs = [0.01 0.01];

w_ps = fcuts/(fsamp/2);
w_c = sqrt(w_ps(1)*w_ps(2));

wp = w_ps(1);
ws = w_ps(2);

Ap = -20*log10(1-devs(1));
As = -20*log10(devs(2));
Amin = As + 20;
Ajust_Glin = 10^((-Ap/2)/20);

[n, Wn, beta, ftype] = kaiserord(fcuts, mags, devs, fsamp);
n = ceil(n*(ws-wp)/(ws-wp));

h_chebwin = fir1(n, Wn, chebwin(n+1, As+3));

[Hw,w] = freqz(h_chebwin);

plot(w/pi, mag2db(abs(Hw)));
title(['Chebwin = '    num2str(n)]);

hold on; 
plot([0 ws ws 1],-[0 0 As As]); % mascara
plot([0 wp wp], -[Ap Ap Amin], ':m'); 
hold off;
ylim([-Amin 5]);

