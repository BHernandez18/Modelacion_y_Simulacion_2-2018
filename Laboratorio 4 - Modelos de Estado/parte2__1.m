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

% ---
% Proceso 1 - Definicion de parametros de entrada.
% ---
[F1__a, Area__a, h1_0__a, h2_0__a] = deal(10, 1.5, 1,  2);  % Sistema 1
[F1__b, Area__b, h1_0__b, h2_0__b] = deal( 5,   2, 1,  5);  % Sistema 2
[F1__c, Area__c, h1_0__c, h2_0__c] = deal( 3,   4, 1, 10);  % Sistema 3

% ---
% Obtencion de matrices de coeficientes de los 'Modelos de Espacio de Estados'
% ---
[A__a, B__a, C__a, D__a] = modeloEspacioEstados(F1__a, Area__a, h1_0__a, h2_0__a); % Sistema 1
[A__b, B__b, C__b, D__b] = modeloEspacioEstados(F1__b, Area__b, h1_0__b, h2_0__b); % Sistema 2
[A__c, B__c, C__c, D__c] = modeloEspacioEstados(F1__c, Area__c, h1_0__c, h2_0__c); % Sistema 3

% ---
% Conversion de 'Modelos de Espacio de Estados' a 'Funciones de Transferencia'
% ---
I__a = eye(size(A__a));
I__b = eye(size(A__b));
I__c = eye(size(A__c));

syms s;
FTs__a = C__a / (s*I__a - A__a) * B__a + D__a; % F. de T. del Sistema 1
FTs__b = C__b / (s*I__b - A__b) * B__b + D__b; % F. de T. del Sistema 2
FTs__c = C__c / (s*I__c - A__c) * B__c + D__c; % F. de T. del Sistema 3

% Obtencion de numerador y denominador, para cada funcion de transferencia.
[n1, d1] = numden(FTs__a);
[n2, d2] = numden(FTs__b);
[n3, d3] = numden(FTs__c);

% Generacion de funciones de transferencia.
tf__a = tf(sym2poly(n1), sym2poly(d1));
tf__b = tf(sym2poly(n2), sym2poly(d2));
tf__c = tf(sym2poly(n3), sym2poly(d3));

% ---
% Respuestas al escalon, para cada uno de los sistemas
% ---
[n1_char, d1_char] = deal(erase(char(n1), '*'), erase(char(d1), '*'));
[n2_char, d2_char] = deal(erase(char(n2), '*'), erase(char(d2), '*'));
[n3_char, d3_char] = deal(erase(char(n3), '*'), erase(char(d3), '*'));

% -- Sistema 1 --
figure(1);
step(tf__a);
title(...
    {strcat('\textbf{Respuesta al escalon para} $H(s) = \frac{', n1_char, '}{', d1_char, '}$')},...
    'Interpreter','latex',...
    'FontSize', 12);
xlabel('Tiempo');
ylabel('Amplitud');
saveas(gcf, 'grafico_Hs_1.png');

% -- Sistema 2 --
figure(2);
step(tf__b);
title(...
    {strcat('\textbf{Respuesta al escalon para} $H(s) = \frac{', n2_char, '}{', d2_char, '}$')},...
    'Interpreter','latex',...
    'FontSize', 12);
xlabel('Tiempo');
ylabel('Amplitud');
saveas(gcf, 'grafico_Hs_2.png');

% -- Sistema 3 --
figure(3);
step(tf__c);
title(...
    {strcat('\textbf{Respuesta al escalon para} $H(s) = \frac{', n3_char, '}{', d3_char, '}$')},...
    'Interpreter','latex',...
    'FontSize', 12);
xlabel('Tiempo');
ylabel('Amplitud');
saveas(gcf, 'grafico_Hs_3.png');

% -------------------------------------------------------------------------
% Definicion de funciones
function [A, B, C, D] = modeloEspacioEstados(F1, Area, h1_0, h2_0)
    A = [0, 0; 0, -1/Area];
    B = [0; 1/Area];
    C = [0, 1];
    D = 0;
end
