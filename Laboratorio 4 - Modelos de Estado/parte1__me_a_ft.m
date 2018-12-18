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

% =======================================================================
% == Programa - Modelo de Estados (ME) a Funcion de Transferencia (FT) ==
A = input('Ingrese la "matriz A" del Modelo de Estados (ME): ');
B = input('Ingrese la "matriz B" del Modelo de Estados (ME): ');
C = input('Ingrese la "matriz C" del Modelo de Estados (ME): ');
D = input('Ingrese la "matriz D" del Modelo de Estados (ME): ');

% Obtencion de las funciones de transferencia
syms s;
format rat;

I = eye(size(A));
FTs = C * inv((s*I - A)) * B + D;

display(FTs)