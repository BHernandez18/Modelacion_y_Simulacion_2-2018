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
[F1__a, Area__a, h1_0__a, h2_0__a] = deal(10, 1.5, 1, 2);   % Sistema 1
[F1__b, Area__b, h1_0__b, h2_0__b] = deal(5, 2, 1, 5);      % Sistema 2
[F1__c, Area__c, h1_0__c, h2_0__c] = deal(5, 1.5, 1, 10);   % Sistema 3

% ---
% Obtencion de matrices de coeficientes de los 'Modelos de Espacio de Estados'
% ---

% >> Sistema 1 <<
A__a = [0, 0; 0, -1/Area__a];
B__a = [0; 1/Area__a];
C__a = [0, 1];
D__a = 0;

% >> Sistema 2 <<
A__b = [0, 0; 0, -1/Area__b];
B__b = [0; 1/Area__b];
C__b = [0, 1];
D__b = 0;

% >> Sistema 3 <<
A__c = [0, 0; 0, -1/Area__c];
B__c = [0; 1/Area__c];
C__c = [0, 1];
D__c = 0;

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
tf__b = tf(sym2poly(n1), sym2poly(d1));
tf__c = tf(sym2poly(n1), sym2poly(d1));

% ---
% Respuestas al escalon, para cada uno de los sistemas
% ---
step(tf__a);
step(tf__b);
step(tf__c);
