%
% Laboratorio 1 - Modelaci�n y Simulaci�n
% << Introducci�n a MATLAB >>
%
% Integrantes:  Pablo C�ceres Luzanto
%               Benjam�n Hern�ndez Cort�s
%
% Fecha: 07 de noviembre de 2018
% Profesor: Gonzalo Acu�a
% Ayudante: Francisco Mu�oz

% =====================================================
% Implementaci�n del M�todo de Newton-Raphson Recursivo

% Funci�n para encontrar la soluci�n (raiz) de una funci�n, utilizando el
% m�todo de Newton-Raphson a partir de 4 par�metros: un polinomio (de 1
% variable), un n�mero m�ximo de iteraciones, un error (o tolerancia) y el
% valor inicial.

function resultado = newton_raphson(polinomio, max_iteraciones, error, x_n)
x_n1 = x_n - (polyval(polinomio, x_n) / polyval(polyder(polinomio), x_n));
if (abs(x_n1 - x_n) <= error || max_iteraciones == 0)
    resultado = x_n1;
else
    resultado = newton_raphson(polinomio, max_iteraciones - 1, error, x_n1);
end