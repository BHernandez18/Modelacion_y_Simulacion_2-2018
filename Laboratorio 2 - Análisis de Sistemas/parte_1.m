%
% Laboratorio 2 - Modelación y Simulación
% << Análisis de sistemas >>
%
% Integrantes:  Pablo Cáceres Luzanto
%               Benjamín Hernández Cortés
%
% Fecha: 22 de noviembre de 2018
% Profesor: Gonzalo Acuña
% Ayudante: Francisco Muñoz
%

% ===================
% == Primera parte ==
%
% Se solicita graficar las respuestas de lazo abierto y lazo cerrado para
% las siguientes funciones.
%
% 1) 4*(dy/dt) + 2*y = 2*(du/dt)
%       y(0) = 1, u(0) = 0
%
% 2) (d^2 y/dt^2) + 4*(dy/dt) + 3*y - (d^2 u/dt^2) - 8*(du/dt) - u = 0
%       y(0) = 1, y'(0) = 1, u(0) = 0, u'(0) = 0
%
% 3) (d^3 y/dt^3) + 2*(d^2 y/dt^2) + y = 5*(du/dt)
%       y(0) = 1, y'(0) = 1, y''(0) = 0, u(0) = 0
%
% El procedimiento consiste en obtener la función de transferencia asociada
% a cada una de las funciones, para lo cual se emplea la Transformada de
% Laplace. Al resolver las funciones, se obtienen las siguientes funciones
% de transferencia:
%
% 1) H1(s) = s / (2*s + 1)
% 2) H2(s) = (s^2 + 8*s + 1) / (s^2 + 4*s + 3)
% 3) H3(s) = 5*s / (s^3 + 2*s^2 + 1)
%
% A continuación, se definen los vectores que representarán el numerador y
% denominador de cada función de transferencia conseguida.

% >> H1(s) -> Función de primer orden. <<
numerador_FdeT_1 = [1 0];
denominador_FdeT_1 = [2 1];

H1_abierto = tf(numerador_FdeT_1, denominador_FdeT_1);
H1_cerrado = feedback(H1_abierto, 1);

% >> H2(s) -> Función de segundo orden. <<
numerador_FdeT_2 = [1 8 1];
denominador_FdeT_2 = [1 4 3];

H2_abierto = tf(numerador_FdeT_2, denominador_FdeT_2);
H2_cerrado = feedback(H2_abierto, 1);

% >> H3(s) -> Función de tercer orden. <<
numerador_FdeT_3 = [0 0 5 0];
denominador_FdeT_3 = [1 2 0 1];

H3_abierto = tf(numerador_FdeT_3, denominador_FdeT_3);
H3_cerrado = feedback(H3_abierto, 1);

% ===========================
% == Obtención de gráficos ==

%
% >> Función de Transferencia H1(s) <<
%
figure(1);
step(H1_abierto);
title({'\textbf{Respuesta al impulso para} $H_{1}(s) = \frac{s}{2s + 1}$ [Abierto]'},...
    'Interpreter','latex',...
    'FontSize', 15);
xlabel('Tiempo');
ylabel('Amplitud');
grid on;
saveas(gcf, 'grafico_H1s_abierto.png');
%-------------------------------------
figure(2);
step(H1_cerrado);
title({'\textbf{Respuesta al impulso para} $H_{1}(s) = \frac{s}{2s + 1}$ [Cerrado]'},...
    'Interpreter','latex',...
    'FontSize', 15);
xlabel('Tiempo');
ylabel('Amplitud');
grid on;
saveas(gcf, 'grafico_H1s_cerrado.png');

%
% >> Función de Transferencia H2(s) <<
%
figure(3);
step(H2_abierto);
title({'\textbf{Respuesta al impulso para} $H_{2}(s) = \frac{s^2 + 8s + 1}{s^2 + 4s + 3}$ [Abierto]'},...
    'Interpreter','latex',...
    'FontSize', 15);
xlabel('Tiempo');
ylabel('Amplitud');
grid on;
saveas(gcf, 'grafico_H2s_abierto.png');
%-------------------------------------
figure(4);
step(H2_cerrado);
title({'\textbf{Respuesta al impulso para} $H_{2}(s) = \frac{s^2 + 8s + 1}{s^2 + 4s + 3}$ [Cerrado]'},...
    'Interpreter','latex',...
    'FontSize', 15);
xlabel('Tiempo');
ylabel('Amplitud');
grid on;
saveas(gcf, 'grafico_H2s_cerrado.png');

%
% >> Función de Transferencia H3(s) <<
%
figure(5);
step(H3_abierto);
title({'\textbf{Respuesta al impulso para} $H_{3}(s) = \frac{5s}{s^3 + 2s^2 + 1}$ [Abierto]'},...
    'Interpreter','latex',...
    'FontSize', 15);
xlabel('Tiempo');
ylabel('Amplitud');
grid on;
saveas(gcf, 'grafico_H3s_abierto.png');
%-------------------------------------
figure(6);
step(H3_cerrado);
title({'\textbf{Respuesta al impulso para} $H_{3}(s) = \frac{5s}{s^3 + 2s^2 + 1}$ [Cerrado]'},...
    'Interpreter','latex',...
    'FontSize', 15);
xlabel('Tiempo');
ylabel('Amplitud');
grid on;
saveas(gcf, 'grafico_H3s_cerrado.png');

% ====================================================================
% == Obtención de ganancia, ceros, polos y tiempo de estabilización ==

[num, den] = tfdata(H1_abierto, 'v');
[Z1_abierto, P1_abierto, K1_abierto] = tf2zp(num,den);
[num, den] = tfdata(H1_cerrado, 'v');
[Z1_cerrado, P1_cerrado, K1_cerrado] = tf2zp(num,den);
stepinfo_H1_abierto = stepinfo(H1_abierto);
stepinfo_H1_cerrado = stepinfo(H1_cerrado);

% Ganancia, ceros y polos - funcion 2do orden
[num, den] = tfdata(H2_abierto, 'v');
[Z2_abierto, P2_abierto, K2_abierto] = tf2zp(num,den);
[num, den] = tfdata(H2_cerrado, 'v');
[Z2_cerrado, P2_cerrado, K2_cerrado] = tf2zp(num,den);
stepinfo_H2_abierto = stepinfo(H2_abierto);
stepinfo_H2_cerrado = stepinfo(H2_cerrado);

% Ganancia, ceros y polos - funcion 3er orden
[num, den] = tfdata(H3_abierto, 'v');
[Z3_abierto, P3_abierto, K3_abierto] = tf2zp(num,den);
[num, den] = tfdata(H3_cerrado, 'v');
[Z3_cerrado, P3_cerrado, K3_cerrado] = tf2zp(num,den);
stepinfo_H3_abierto = stepinfo(H3_abierto);
stepinfo_H3_cerrado = stepinfo(H3_cerrado);

fprintf(">> Información respecto a las Funciones de Transferencia <<\n");
fprintf("-----------------------------------------------------------\n");
fprintf("Cero (H1_abierto): %.4f\n", Z1_abierto);
fprintf("Polo (H1_abierto): %.4f\n", P1_abierto);
fprintf("Ganancia (H1_abierto): %.4f\n", K1_abierto);
fprintf("Tiempo de estabilización (H1_abierto): %.4f\n\n", stepinfo_H1_abierto.SettlingTime);

fprintf("Cero (H1_cerrado): %.4f\n", Z1_cerrado);
fprintf("Polo (H1_cerrado): %.4f\n", P1_cerrado);
fprintf("Ganancia (H1_cerrado): %.4f\n", K1_cerrado);
fprintf("Tiempo de estabilización (H1_cerrado): %.4f\n\n", stepinfo_H1_cerrado.SettlingTime);
fprintf("-----------------------------------------------------------\n");
fprintf("Cero (H2_abierto): %.4f\n", Z2_abierto);
fprintf("Polo (H2_abierto): %.4f\n", P2_abierto);
fprintf("Ganancia (H2_abierto): %.4f\n", K2_abierto);
fprintf("Tiempo de estabilización (H2_abierto): %.4f\n\n", stepinfo_H2_abierto.SettlingTime);

fprintf("Cero (H2_cerrado): %.4f\n", Z2_cerrado);
fprintf("Polo (H2_cerrado): %.4f\n", P2_cerrado);
fprintf("Ganancia (H2_cerrado): %.4f\n", K2_cerrado);
fprintf("Tiempo de estabilización (H2_cerrado): %.4f\n\n", stepinfo_H2_cerrado.SettlingTime);
fprintf("-----------------------------------------------------------\n");
fprintf("Cero (H3_abierto): %.4f\n", Z3_abierto);
fprintf("Polo (H3_abierto): %.4f%+.4fi\n", real(P3_abierto), imag(P3_abierto));
fprintf("Ganancia (H3_abierto): %.4f\n", K3_abierto);
fprintf("Tiempo de estabilización (H3_abierto): %.4f\n\n", stepinfo_H3_abierto.SettlingTime);

fprintf("Cero (H3_cerrado): %.4f\n", Z3_cerrado);
fprintf("Polo (H3_cerrado): %.4f%+.4fi\n", real(P3_cerrado), imag(P3_cerrado));
fprintf("Ganancia (H3_cerrado): %.4f\n", K3_cerrado);
fprintf("Tiempo de estabilización (H1_cerrado): %.4f\n\n", stepinfo_H3_cerrado.SettlingTime);
fprintf("-----------------------------------------------------------\n");