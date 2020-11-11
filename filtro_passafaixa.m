% Exemplo 3: Filtro passa-faixa (fp1 = 811 Hz, fp2 = 895,5 Hz fs1 = 770 Hz, fs2 = 1209 Hz, Ap = 1 dB, Ar = 30 dB)

clc
clear all;
close all;


% Criando os dados

fp1 = 811;
fp2 = 895.5;

fs1 = 770;
fs2 = 1209;

wp1 = 2*pi*fp1;
wp2 = 2*pi*fp2;
ws1 = 2*pi*fs1;
ws2 = 2*pi*fs2;

Ap = 1;
As = 30;

omega_o = sqrt(wp1*wp2);
B = abs(wp2 - wp1);

omega_p = 1;
omega_s1 = abs((-ws1^2 + omega_o^2)/(B*ws1));
omega_s2 = abs((-ws2^2 + omega_o^2)/(B*ws2));

omega_s = min(omega_s1,omega_s2);

% Criando protótipo
[n,Wn] = buttord(omega_p, omega_s, Ap, As,'s');
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
[h, w] = freqs(real(sym2poly(bs)), real(sym2poly(as)), 10000);      % Retirando dados de H(s) para plotar

figure(3)
subplot(2,1,1);
semilogx(w/(2*pi),mag2db(abs(h))); %Plotando magnitude;
title('Magnitude');
grid;
hold on;
plot([fp1, fs1, fs2, fp2], -[Ap As, As Ap], 'xk'); %Plotando pontos de frequẽncia;
hold off;

subplot(2,1,2);
semilogx(w/(2*pi),unwrap(angle(h))/pi);
title('Fase');
grid;

figure(4)
zplane(sym2poly(bs),sym2poly(as));
title('Passa baixa Butterworth');
