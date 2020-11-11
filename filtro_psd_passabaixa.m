% Exemplo 3: Filtro digital passa-baixas (fp = 941Hz, fs = 1209 Hz, Ap = 1 dB, As = 20 dB)

%% Filtro analógico passa baixas comum com frequências lambda distorcidas para compensar a distorção da transformação bilinear

clc;
clear all;
close all;

% Dados iniciais

fa = 1;

Ap = 1;
As = 20;

fs = 1209;
fp = 941;

ws = 2*pi*fs;
wp = 2*pi*fp;

teta_s = fs/fa/2;
teta_p = fp/fa/2;

lambda_s = 2*tan((pi*teta_s)/2);
lambda_p = 2*tan((pi*teta_p)/2);

omega_p = 1;
omega_s = lambda_s/lambda_p;

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
P = s/lambda_s;
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

% Transformação bilinear;

syms z;
T = 2*fa*((z-1)/(z+1));

Hz = subs(Hs,T);

[bz_sym,az_sym] = numden(Hs);

az = sym2poly(az_sym);
bz = sym2poly(bz_sym);

% normalização
an = az(1);
bzn = bz/an;
azn = az/an;

[h, w] = freqz(bzn, azn, 10000);

figure(4)
subplot(2,1,1);
semilogx((w/(2*pi))*fa,mag2db(abs(h))); %Plotando magnitude;
title('Magnitude');

grid;
hold on;
plot([lambda_p, lambda_s], -[Ap, As], 'xk'); %Plotando pontos de frequẽncia;
hold off;

subplot(2,1,2);
semilogx((w/(2*pi)),unwrap(angle(h))/pi);
title('Fase');
grid;

figure(5)
zplane(sym2poly(bs),sym2poly(as));
title('Plano Z de um passa baixa Butterworth');
