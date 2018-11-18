%
% Laboratorio 2 - Modelaci�n y Simulaci�n
% << An�lisis de sistemas >>
%
% Integrantes:  Pablo C�ceres Luzanto
%               Benjam�n Hern�ndez Cort�s
%
% Fecha: 22 de noviembre de 2018
% Profesor: Gonzalo Acu�a
% Ayudante: Francisco Mu�oz
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
% El procedimiento consiste en obtener la funci�n de transferencia asociada
% a cada una de las funciones, para lo cual se emplea la Transformada de
% Laplace. Al resolver las funciones, se obtienen las siguientes funciones
% de transferencia:
%
% 1) H1(s) = s / (2*s + 1)
% 2) H2(s) = (s^2 + 8*s + 1) / (s^2 + 4*s + 3)
% 3) H3(s) = 5*s / (s^3 + 2*s^2 + 1)
%
% A continuaci�n, se definen los vectores que representar�n el numerador y
% denominador de cada funci�n de transferencia conseguida.

% >> H1(s) -> Funci�n de primer orden. <<
numerador_FdeT_1 = [1 0];
denominador_FdeT_1 = [2 1];

H1_abierto = tf(numerador_FdeT_1, denominador_FdeT_1);
H2_cerrado = feedback(H1_abierto, 1);

% >> H2(s) -> Funci�n de segundo orden. <<
numerador_FdeT_2 = [1 8 1];
denominador_FdeT_2 = [1 4 3];

H2_abierto = tf(numerador_FdeT_2, denominador_FdeT_2);
H2_cerrado = feedback(H2_abierto, 1);

% >> H3(s) -> Funci�n de tercer orden. <<
numerador_FdeT_3 = [0 0 5 0];
denominador_FdeT_3 = [1 2 0 1];

H3_abierto = tf(numerador_FdeT_3, denominador_FdeT_3);
H3_cerrado = feedback(H3_abierto, 1);

% ===========================
% == Obtenci�n de gr�ficos ==
%
figure(1);
step(H1_abierto);
