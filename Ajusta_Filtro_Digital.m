clc
clear all
close all

%Projetar um filtro passa baixas usando uma janela temporal fixa (verificar a janela que atende a especificação)
%wp = 0.2*pi; Ap = 0.2 dB; Gp = 0 dB
%ws = 0.3*pi; As = 60 dB;

wp = 0.2*pi;
ws = 0.3*pi;
Ap = 0.2;
As = 50;
Gp = 0;

% Calculando wc, frequência de corte 
wc = sqrt(ws*wp);           

% Ordem
N = 20;                     

% Criando eixo do tempo discreto, sempre de -Ordem/2:1:Ordem/2
n = -N:1:N;            

% Criando o h(n), CLP; 
clp = sin(wc.*n)./(pi.*n);    
clp(N+1) = wc/pi;

% Criando o eixo para janela de Bohman
x = linspace(-1,1,2*N+1);

%% Criando a janela de Bohman
wb = (1-abs(x)).*cos(pi*abs(x))+(1/pi)*sin(pi*abs(x));

% Multiplicando a janela pelo protótipo do filtro:
H = wb.*clp;

% Pegando magnittude e angulo de h
[h,w] = freqz(H,1);

freqz(H,1);

%% Correção de H para estar abaixo de zero e Ap

% Multiplicando pela metade do ganho:
H = H*(10^((-Ap/2)/20));

%% Recalculando e plotando:

figure(1);
[h,w] = freqz(H,1);
freqz(H,1);
hold on;
plot([0 wp wp], -[Ap Ap As+20], ':r');
hold on
plot([0 ws ws 1], -[0 0 As As], ':m');

fvtool(H,1);    % Deu certo:

figure(2);
freqz(H,1);
hold on;
plot([0 wp wp], -[Ap Ap As+20], ':r');
hold on
plot([0 ws ws 1], -[0 0 As As], ':m');

%% Correção para estar entre as frequẽncias exigidas:

hs = abs(h);
hsd = mag2db(hs);

pos = sum(hsd>-0.2);
wsmedido = w(pos);

pos = sum(hsd>-50);
wpmedido = w(pos);








