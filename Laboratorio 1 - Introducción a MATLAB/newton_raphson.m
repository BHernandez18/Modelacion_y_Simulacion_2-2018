%
% Laboratorio 1 - Modelación y Simulación
% << Introducción a MATLAB >>
%
% Integrantes:  Pablo Cáceres Luzanto
%               Benjamín Hernández Cortés
%
% Fecha: 07 de noviembre de 2018
% Profesor: Gonzalo Acuña
% Ayudante: Francisco Muñoz

% =====================================================
% Implementación del Método de Newton-Raphson Recursivo

% Función para encontrar la solución (raiz) de una función, utilizando el
% método de Newton-Raphson a partir de 4 parámetros: un polinomio (de 1
% variable), un número máximo de iteraciones, un error (o tolerancia) y el
% valor inicial.

function resultado = newton_raphson(polinomio, max_iteraciones, error, x_n)
x_n1 = x_n - (polyval(polinomio, x_n) / polyval(polyder(polinomio), x_n));
if (abs(x_n1 - x_n) <= error || max_iteraciones == 0)
    resultado = x_n1;
else
    resultado = newton_raphson(polinomio, max_iteraciones - 1, error, x_n1);
end