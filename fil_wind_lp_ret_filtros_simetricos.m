
%% Filtro passa baixa com transformada de Fourier

clear all
close all
clc

M = 1000;
wc = 0.2*pi;

n = -M:M;

h = sin(wc*n)./(pi*n);

posProb = M+1;

h(M+1) = wc/pi;

stem(n, h);
title('Filtro calculado pela série de Fourier');

figure(2);
zplane(h, 1);
xlim([-3 3]);

figure(3);
freqz(h,1);

figure(4);
grpdelay(h,1);

fvtool(h,1);

%% Filtro passa alta com transformada de Fourier

% Depois de calcular a série de fourier tem-se

%chp(n) = 1-wc/pi ---> para n = 0
%chp(n) = -sin(2wc*n)/(pi*n) ----> para n != 0

close all 
clear all
clc

M = 100;
wc = 0.2*pi;

n = -M:M;

h = -sin(wc*n)./(pi*n);

posProb = M+1;

h(M+1) = 1 - wc/pi;

stem(n, h);
title('Filtro calculado pela série de Fourier');

figure(2);
zplane(h, 1);
xlim([-3 3]);

figure(3);
freqz(h,1);

figure(4);
grpdelay(h,1);

%% Filtro passa alta com transformada de Fourier

close all 
clear all
clc

% Depois de calcular a série de fourier tem-se

% chp(n) = (wc2-wc1)/pi ---> para n = 0
% chp(n) = (1/pi*n)(sin(wc2*n)-sin(wc1*n)) ----> para n != 0


M = 50;
wc2 = 0.55*pi;
wc1 = 0.5*pi

n = -M:M;

h = (1/pi*n).*(sin(wc2*n)-sin(wc1*n));

posProb = M+1;

h(posProb) = (wc2-wc1)/pi;

figure(1);
stem(n, h);
title('Filtro calculado pela série de Fourier');

figure(2);
zplane(h, 1);
xlim([-3 3]);

figure(3);
fvtool(h,1);

figure(4);
grpdelay(h,1);

