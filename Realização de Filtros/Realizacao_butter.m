clc
clear all 
close all

%% ------------

fp1 = 10000;
fp2 = 12000;

fs1 = 9000;
fs2 = 13000;

wp1 = 2*pi*fp1;
wp2 = 2*pi*fp2;
ws1 = 2*pi*fs1;
ws2 = 2*pi*fs2;

Ap = 1;
As = 50;

omega_o = sqrt(wp1*wp2);
B = abs(wp2 - wp1);

omega_p = 1;
omega_s1 = abs((-ws1^2 + omega_o^2)/(B*ws1));
omega_s2 = abs((-ws2^2 + omega_o^2)/(B*ws2));

omega_s = min(omega_s1,omega_s2);

% Criando protótipo
[n,Wn] = buttord(Wp,Ws,Rp,Rs);
[b,a] = butter(n,Wn, 's');

% Plotando protótipo
freqs(b,a);

figure(2);
zplane(b,a);
title('Plano Z do protótipo');

syms p;

Hp = (poly2sym(b,p)/poly2sym(a,p));

syms s;
P = ( ((s^2)+(omega_o^2))/(B*s) );

Hs = subs(Hp,P);

[bs, as] = numden(Hs);
[h, w] = freqs(real(sym2poly(bs)), real(sym2poly(as)), 10000);      % Retirando dados de H(s)


[n,Wn] = buttord(Wp, Ws, Ap, As,'s')
[b,a] = butter(n,Wn, 's');

%% -------------

b = bs;
a = as;

%N = 400;
%b = ones(N,1)/N;
N = length(b)-1;

i = 1;

x = zeros(N,1);
s = zeros(length(r),1);

while i< length(r)
    
    k = N;
    while k > 1
       x(k) = x(k-1);        
       k = k - 1;
    end
    
    x(1) = r(i);
    
    k = 1;
    while k <= N
        s(i) = s(i) + b(k)*x(k);
        k = k + 1;
    end
    
    i = i + 1;    
end

t = 1:1:size(r);

plot(t, r, ':b', t, s, '+r');

S = fftshift(fft(s)/length(s));
R = fftshift(fft(r)/length(r));

f = linspace(-1,1,length(r));

figure(2);
subplot(2,1,1);
plot(f, 20*log10(abs(R)));

subplot(2,1,2);
plot(f, 20*log10(abs(S)));

figure(3);
freqz(b,1);
