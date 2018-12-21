clear all;
%
% Laboratorio 3 - Modelacion y Simulacion
% << Modelos de Estado >>
%
% Integrantes:  Pablo Caceres Luzanto
%               Benjamin Hernandez Cortes
%
% Fecha: 21 de Diciembre de 2018
% Profesor: Gonzalo Acuña
% Ayudante: Francisco Muñoz
%

% ====================================================================================
% == Programa - Modelado de sistema de estanques con 'Modelo de Espacio de Estados' ==

% --------------------------------------------------------------------
% DESARROLLO DE SOLUCIONES PARA 3 CASOS BASADOS EN UN ÚNICO PROBLEMA Y
% UN 4TO CASO BASADO EN UN PROBLEMA ALTERNATIVO.

% ---
% Proceso 1 - Definicion de parametros de entrada.
% ---
[F1__a, Area__a, h1_0__a, h2_0__a] = deal(10, 1.5, 1,  2);  % Sistema 1
[F1__b, Area__b, h1_0__b, h2_0__b] = deal( 5,   2, 1,  5);  % Sistema 2
[F1__c, Area__c, h1_0__c, h2_0__c] = deal( 3,   4, 1, 10);  % Sistema 3
[A1, A2, R1, R2] = deal(2, 4, 1/4, 1/16);   % Sistema 4

% ---
% Proceso 2 - Obtencion de matrices de coeficientes de los 'Modelos de Espacio de Estados'
% ---
[A__a, B__a, C__a, D__a] = modeloEspacioEstados_1(F1__a, Area__a, h1_0__a, h2_0__a); % Sistema 1
[A__b, B__b, C__b, D__b] = modeloEspacioEstados_1(F1__b, Area__b, h1_0__b, h2_0__b); % Sistema 2
[A__c, B__c, C__c, D__c] = modeloEspacioEstados_1(F1__c, Area__c, h1_0__c, h2_0__c); % Sistema 3
[A, B, C, D] = modeloEspacioEstados_2(A1, A2, R1, R2);  % Sistema 4
% ---
% Proceso 3 - Conversion de 'Modelos de Espacio de Estados' a 'Funciones de Transferencia'
% ---
I__a = eye(size(A__a)); % Generacion de 'matrices identidad', acordes a las
I__b = eye(size(A__b)); % dimensiones de las matrices A.
I__c = eye(size(A__c)); %
I = eye(size(A));       %

syms s; % Definición de variables simbolicas
FTs__a = C__a / (s*I__a - A__a) * B__a + D__a; % F. de T. del caso 1
FTs__b = C__b / (s*I__b - A__b) * B__b + D__b; % F. de T. del caso 2
FTs__c = C__c / (s*I__c - A__c) * B__c + D__c; % F. de T. del caso 3
FTs = C / (s*I - A) * B + D; % F. de T. del caso 4

% ---
% Proceso 4 - Desarrollo de funciones de transferencia.
% ---
[n1, d1] = numden(FTs__a);  % Obtencion del numerador y denominador
[n2, d2] = numden(FTs__b);  % de cada funcion de transferencia
[n3, d3] = numden(FTs__c);  % conseguida.
[n, d] = numden(FTs);

tf__a = tf(sym2poly(n1), sym2poly(d1)); % Creacion de objeto 'tf' para
tf__b = tf(sym2poly(n2), sym2poly(d2)); % definir cada funcion de
tf__c = tf(sym2poly(n3), sym2poly(d3)); % transferencia.
tf = tf(sym2poly(n), sym2poly(d));

% ---
% Proceso 5 - Analisis de respuestas al escalon, para cada uno de los sistemas
% ---

[n1_char, d1_char] = deal(erase(char(n1), '*'), erase(char(d1), '*'));
[n2_char, d2_char] = deal(erase(char(n2), '*'), erase(char(d2), '*'));
[n3_char, d3_char] = deal(erase(char(n3), '*'), erase(char(d3), '*'));
[n_char, d_char] = deal(erase(char(n), '*'), erase(char(d), '*'));

% --- Figuras de respuesta al escalon para cada 'Funcion de Transferencia
% --- definida anteriormente. 

% -- Sistema 1 --
figure(1);
step(tf__a);
title(...
    {strcat('\textbf{Respuesta al escalon para} $H(s) = \frac{', n1_char, '}{', d1_char, '}$ [Caso 1]')},...
    'Interpreter','latex',...
    'FontSize', 12);
xlabel('Tiempo');
ylabel('Amplitud');
saveas(gcf, 'grafico_Hs_1.png');

% -- Sistema 2 --
figure(2);
step(tf__b);
title(...
    {strcat('\textbf{Respuesta al escalon para} $H(s) = \frac{', n2_char, '}{', d2_char, '}$ [Caso 2]')},...
    'Interpreter','latex',...
    'FontSize', 12);
xlabel('Tiempo');
ylabel('Amplitud');
saveas(gcf, 'grafico_Hs_2.png');

% -- Sistema 3 --
figure(3);
step(tf__c);
title(...
    {strcat('\textbf{Respuesta al escalon para} $H(s) = \frac{', n3_char, '}{', d3_char, '}$ [Caso 3]')},...
    'Interpreter','latex',...
    'FontSize', 12);
xlabel('Tiempo');
ylabel('Amplitud');
saveas(gcf, 'grafico_Hs_3.png');

% -- Sistema 4 --
figure(4);
step(tf);
title(...
    {strcat('\textbf{Respuesta al escalon para} $H(s) = \frac{', n_char, '}{', d_char, '}$ [Caso 4]')},...
    'Interpreter','latex',...
    'FontSize', 12);
xlabel('Tiempo');
ylabel('Amplitud');
saveas(gcf, 'grafico_Hs_4.png');

% -------------------------------------------------------------------------
% -- Definicion de funciones

% Funcion para obtener las matrices del Modelo de Espacio de Estados
% asociadas al primer problema.
function [A, B, C, D] = modeloEspacioEstados_1(F1, Area, h1_0, h2_0)
    A = [0, 0; 0, -1/Area];
    B = [0; 1/Area];
    C = [0, 1];
    D = 0;
end

% Funcion para obtener las matrices del Modelo de Espacio de Estados
% asociadas al segundo problema.
function [A, B, C, D] = modeloEspacioEstados_2(A1, A2, R1, R2)
    A = [-1/(R1*A1), 1/(R1*A2); 1/(R1*A2), -1/(R1*A2) - 1/(R2*A2)];
    B = [1/A1; 0];
    C = [0, 1/R2];
    D = 0;
end