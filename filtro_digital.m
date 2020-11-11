clear all;
close all;
clc;

syms s; %simbolico s
N = 0; % N =  ordem do filtro

as = 50;
ap = 1;

fp1 = 12e3;
fp2 = 19e3;
fs1 = 10e3;
fs2 = 25e3;

wp1 = 2*pi*fp1;
wp2 = 2*pi*fp2;
ws1 = 2*pi*fs1;
ws2 = 2*pi*fs2;

w0 = sqrt(wp1*wp2);
B = wp2-wp1; 

omega_p = 1;
Op = omega_p;

A1 = (-ws1.^2) + (w0^2);
A2 = (-ws2.^2) + (w0^2);

omega_s1 = abs(A1/(B*ws1));
omega_s2 = abs(A2/(B*ws2));

Os = min(omega_s1,omega_s2);

P = ( ((s^2)+(w0^2))/(B*s) );

%Subs de variaveis
Wp = Op; % Omega P
Ws = Os; % Omega S
Ap = ap; % Atenuaçao de passagem
As = as; % Atenuação de stop

% Transformação de frequência

% Chebyshev II
N = cheb2ord(Wp, Ws, Ap, As,'s'); 
[b,a] = cheby2(N,As, Ws, 's');
figure(3)
zplane(b,a)
title('Passa-Baixa Cheby II')

syms p;
Hp = (poly2sym(b,p))/(poly2sym(a,p));
Hs = subs(Hp,P); % P faz alterar a frequencia de um filtro passa baixa -> passa faixa


[bs,as] = numden(Hs);
[h,w] = freqs(real(sym2poly(bs)),real(sym2poly(as)),10e3);
figure(1)
subplot(211)
semilogx(w/(2*pi),mag2db(abs(h))); 
title('Filtro')
hold on; 
grid;

plot([fp1,fs1,fs2,fp2] , -[Ap,As,As,Ap], 'xk');% marcar X preto em (fp,fs) e -(ap,as) 
hold off;
subplot(212)
semilogx(w/(2*pi),unwrap(angle(h))/pi); 
title('Fase')
grid;

figure(2)
zplane(sym2poly(bs),sym2poly(as))
title('Passa-faixa Cheby II')

%% Transformação bilinear


