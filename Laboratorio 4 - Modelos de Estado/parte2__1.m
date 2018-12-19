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
% Construccion de los 'Modelos de Espacio de Estados'
% ---
% >> Sistema 1 <<
G__a = ss(A__a, B__a, C__a, D__a);
h0__a = [h1_0__a; h2_0__a];

% >> Sistema 2 <<
G__b = ss(A__b, B__b, C__b, D__b);
h0__b = [h1_0__b; h2_0__b];

% >> Sistema 3 <<
G__c = ss(A__c, B__c, C__c, D__c);
h0__c = [h1_0__c; h2_0__c];

% ---
% Respuestas del sistema con condiciones iniciales
% ---
initial(G__a, h0__a);
initial(G__b, h0__b);
initial(G__c, h0__c);

