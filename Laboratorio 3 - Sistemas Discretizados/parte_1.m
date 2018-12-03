%
% Laboratorio 3 - Modelacion y Simulacion
% << Sistemas Discretizados >>
%
% Integrantes:  Pablo Caceres Luzanto
%               Benjamin Hernandez Cortes
%
% Fecha: 22 de Noviembre de 2018
% Profesor: Gonzalo Acuña
% Ayudante: Francisco Muñoz
%

% ===================
% == Primera parte ==
%
% A partir de la siguiente ecuacion diferencial, con condiciones iniciales
% nulas:
%
% 14(d^2 y/dt^2) - 7(dy/dt) + 21y(t) - 5(du/dt) - 15u(t) = 0
%
% Tomando como entrada el escalon, se debe:
%
% 1) Encontrar la respuesta continua (1 grafico)
% 2) Realizar el proceso de discretizacion (2 graficos)
% 3) Volver al espacio continuo, con tiempo de muestreo de 0.1 (1 grafico)
%
%
% Al resolver la ecuacion diferencial, se obtiene la siguiente funcion de
% transferencia.
%
% H(s) = (5s + 15) / (14s^2 - 7s + 21)
%
% -------------------------------------------------------------------------
num_FdeT = [0 5 15];    % Numerador de la F. de Transferencia
den_FdeT = [14 -7 21];  % Denominador de la F. de Transferencia
H = tf(num_FdeT, den_FdeT);

% Respuesta el Escalon para la F. de Transferencia obtenida
figure(1);
step(H);
title({'\textbf{Respuesta al escalon para} $H(s) = \frac{5s + 15}{14s^2 - 7s + 21}$'},...
    'Interpreter','latex',...
    'FontSize', 12);
xlabel('Tiempo');
ylabel('Amplitud');
saveas(gcf, 'grafico_Hs.png');

% Dado que el sistema se vuelve inestable con el paso del tiempo, se
% realizara un analisis en torno a los primeros 15 segundos de la
% respuesta.
figure(2);
step(H);
grid on;
title({'\textbf{Respuesta al escalon para} $H(s) = \frac{5s + 15}{14s^2 - 7s + 21}$ [Continuo]'},...
    'Interpreter','latex',...
    'FontSize', 12);
xlabel('Tiempo');
ylabel('Amplitud');
xlim([0 15]);
saveas(gcf, 'grafico_Hs_delimitado.png');

% -------------------------------------------------------------------------
% Se procede a realizar la discretizacion de la F. de Transferencia,
% empleando dos tiempos de muestreo distintos.

% Tiempos de muestreo
T1 = 0.01;
T2 = 0.1;

% Discretizacion del sistema
H1_discreto = c2d(H, T1, 'zoh');
H2_discreto = c2d(H, T2, 'zoh');

% Numerador y Denominador de ambos sistemas discretizados.
% << H1 - Discreto >>
num1_discreto = H1_discreto.Numerator;
den1_discreto = H1_discreto.Denominator;

% << H2 - Discreto >>
num2_discreto = H2_discreto.Numerator;
den2_discreto = H2_discreto.Denominator;

% Obtencion de puntos a graficar para cada sistema discretizado.
N1_puntos = 15/T1;
N2_puntos = 15/T2;

[y1_discreto] = dstep(num1_discreto, den1_discreto, N1_puntos + 1);
[x1_discreto] = 0:0.01:0.01*N1_puntos;

[y2_discreto] = dstep(num2_discreto, den2_discreto, N2_puntos + 1);
[x2_discreto] = 0:0.1:0.1*N2_puntos;

% Graficas obtenidas para los sistemas discretos
figure(3);
subplot(2, 1, 1);
stairs(x1_discreto, y1_discreto);
grid on;
title({'$H1_{discreto}(z) = \frac{0.01942 z - 0.01671}{z^2 - 2.022 z + 1.025}$ [T = 0.01]'},...
    'Interpreter','latex',...
    'FontSize', 14);
ylabel('Amplitud');

subplot(2, 1, 2);
stairs(x2_discreto, y2_discreto);
grid on;
title({'$H2_{discreto}(z) = \frac{0.04197 z - 0.031}{z^2 - 2.036 z + 1.051}$ [T = 0.1]'},...
    'Interpreter','latex',...
    'FontSize', 14);
xlabel('Tiempo');
ylabel('Amplitud');

saveas(gcf, 'graficos_Hdiscretrizados.png');

% -------------------------------------------------------------------------
% Se transforma la funcion de discreta a continua
Tc = 0.1;
[num_continuo, den_continuo] = d2cm(num1_discreto, den1_discreto, Tc, 'zoh');

% Grafica obtenida para el sistema continuo conseguido
figure(4);
step(num_continuo, den_continuo);
grid on;
title({'$H2_{continuo}(s) = \frac{0.0357s - 0.0107}{s^2 - 0.05s + 0.015}$ [T = 0.1]'},...
    'Interpreter','latex',...
    'FontSize', 14);
ylabel('Amplitud');
xlabel('Tiempo');
xlim([0 150]);
saveas(gcf, 'grafico_H_discreto-a-continuo.png');
% Dado que para el sistema discretizado se necesitaron 150 puntos para
% realizar la grafica, esto implica que el grafico resultante posee el
% eje X en milisegundos y no en segundos como se indica en el.