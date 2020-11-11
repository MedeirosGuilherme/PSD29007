%% Criando coeficientes para o filtro digital do tipo 1
clc
clear all
close all

b = [.7 .5 .3 2 1 2 .3 .5 .7];  %Coeficientes simétricos

figure(1);
zplane(b,1);
title('Zplane: Sem zeros em 0 e pi -> pode ser pb e pA');

figure(2);
freqz(b,1);

figure(3)
grpdelay(b,1);
title('atraso de grupo constante');

%% Criando coeficientes para o filtro digital do tipo II

clear all
close all
clc

b = [7 5 3 2 2 3 5 7];  %Coeficientes simétricos sem membro central

figure(1);
zplane(b,1);
title('Zplane: Sem zeros em 0 e pi -> pode ser pb e pA');

figure(2);
freqz(b,1);

figure(3)
grpdelay(b,1);
title('atraso de grupo constante');


%% Criando coeficientes para o filtro digital do tipo III

clear all
close all
clc

b = [7 5 3 2 0 -2 -3 -5 -7];  %Coeficientes assimétricos

figure(1);
zplane(b,1);
title('Zplane: Sem zeros em 0 e pi -> pode ser pb e pA');

figure(2);
freqz(b,1);

figure(3)
grpdelay(b,1);
title('atraso de grupo constante');

%% Criando coeficientes para o filtro digital do tipo IV

clear all
close all
clc

b = [7 5 3 2 -2 -3 -5 -7];  %Coeficientes assimétricos sem membro central

figure(1);
zplane(b,1);
title('Zplane: Sem zeros em 0 e pi -> pode ser pb e pA');

figure(2);
freqz(b,1);

figure(3)
grpdelay(b,1);
title('atraso de grupo constante');
