Repositório da disciplina de Processamento de Sinais Digitais do curso de Engenharia de Telecomunicações do IFSC de São José

# Criando filtros no matlab

## Criando protótipo passa baixa:

- O objetivo aqui é criar um filtro com ganho de passagem Ap = 1 e frequência de passagem wc = 1.

Então, primeiro, definindo a frequência de passagem como

    omega_p = 1

O projeto de cada tipo de filtro se define como:

- Butterworth
[n,Wn] = buttord(Wp, Ws, Ap, As,'s')
[b,a] = butter(n,Wn, 's');
 
- Chebyshev I
n = cheb1ord(Wp, Ws, Ap, As,'s')
[b,a] = cheby1(n,Ap, Wp, 's');
 
- Chebyshev II
n = cheb2ord(Wp, Ws, Ap, As,'s')
[b,a] = cheby2(n,As, Ws, 's');
 
- Elliptic - Cauer
[n, Wn] = ellipord(Wp, Ws, Ap, As,'s')
[b,a] = ellip(n,Ap,As, Wn, 's');

onde 

- n é a ordem do filtro
- Wn é a frequência de corte
- Wp é a frequência de pass
- Ws é a frequência de stop
- Ap é a atenuação na passagem
- As é a atenuação de Stop

