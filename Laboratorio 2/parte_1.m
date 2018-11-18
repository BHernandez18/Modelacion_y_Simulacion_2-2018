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
H2_cerrado = feedback(H1_abierto, 1);

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
figure(1);
step(H1_abierto);
