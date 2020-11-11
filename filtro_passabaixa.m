%% Exemplo 1: Filtro passa-baixas (fp = 941Hz, fs = 1209 Hz, Ap = 1 dB, As = 20 dB) butterworth

clc;
clear all;
close all;

% Dados iniciais

Ap = 1;
As = 20;

fs = 1209;
fp = 941;

ws = 2*pi*fs;
wp = 2*pi*fp;

omega_p = 1; 
omega_s = ws/wp;

% Criando o protótipo

[n,Wn] = buttord(omega_p, omega_s, Ap, As,'s'); % Gerando ordem e frequência de corte
[b,a] = butter(n,Wn, 's'); % Criando numerador e denominador do filtro

% Plotando o protótipo

freqs(b,a);
title('Espectro do filtro protótipo');

figure(2);
zplane(b,a);
title('Plano Z do filtro protótipo');

% Fazendo a transformação de frequência:

syms p;
Hp = (poly2sym(b,p)/poly2sym(a,p)); % Criando H(p)

syms s;
P = s/ws;
Hs = subs(Hp, P);       % Fazendo a substituição de H(p) por H(s) segundo a transformação

[bs,as] = numden(Hs);
[h, w] = freqs(real(sym2poly(bs)), real(sym2poly(as)), 10000);      % Retirando dados de H(s) para plotar

figure(3)
subplot(2,1,1);
semilogx(w/(2*pi),mag2db(abs(h))); %Plotando magnitude;
title('Magnitude');
grid;
hold on;
plot([fp, fs], -[Ap, As], 'xk'); %Plotando pontos de frequẽncia;
hold off;

subplot(2,1,2);
semilogx(w/(2*pi),unwrap(angle(h))/pi);
title('Fase');
grid;


figure(4)
zplane(sym2poly(bs),sym2poly(as));
title('Passa baixa Butterworth');
