clear all;
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
% == Programa - Funcion de Transferencia (FT) a Modelo de Estados (ME) ==

% Obtencion de los coeficientes asociados a las funciones de transferencia.
numerador_ft1 = input('(1) Ingrese el numerador de la FT-1 como constante > a0: ');
denominador_ft1 = input('(1) Ingrese el denominador de la FT-1 como vector > [b1, b0]: ');
numerador_ft2 = input('(2) Ingrese el numerador de la FT-2 como constante > c0: ');
denominador_ft2 = input('(2) Ingrese el denominador de la FT-2 como vector > [d1, d0]: ');

% Coeficientes - Funcion de transferencia 1
a0 = numerador_ft1;     b1 = denominador_ft1(1);
                        b0 = denominador_ft1(2);

% Coeficientes - Funcion de transferencia 2
c0 = numerador_ft2;     d1 = denominador_ft2(1);
                        d0 = denominador_ft2(2);

% Definicion del Modelo de Estados asociado
format rat;
A = [-b0/b1 -a0/b1; c0/d1 -d0/d1];  % Coeficientes de variables de estado
B = [a0/b1; 0];                     % Coeficientes de entradas
C = [1 0];                          % Coeficientes de variables de estado (salida)
D = 0;                              % Coeficientes de entradas (salida)

% Resultados finales
fprintf('\n===============================================\n');
fprintf('== Matrices del Modelo de Espacio de Estados ==\n');
display(A);
display(B);
display(C);
display(D);