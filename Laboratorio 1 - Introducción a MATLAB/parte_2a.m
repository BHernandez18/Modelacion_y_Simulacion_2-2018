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

% ========================
% == Segunda parte - a) ==

% Se solicita implementar el algoritmo de Newton-Raphson y que entregue
% como resultado una ra�z de una funci�n dada o una aproximaci�n de ella.
% Se debe considerar que la funci�n ser� de una sola variable, y que ser�
% dada por consola en formato de polinomio.

polinomio = input('Ingrese el polinomio en formato vector [x1,...,xn]: ');
max_iteraciones = input('Defina la cantidad maxima de iteraciones a realizar (ej. 100): ');
error = input('Defina el error minimo aceptable (ej. 10^-5): ');
x_0 = input('Defina el punto inicial para el m�todo: ');

%
% Llamada a la funci�n de Newton-Raphson implementada.
%
raiz = newton_raphson(polinomio, max_iteraciones, error, x_0);

%
% Visualizaci�n del resultado
%
fprintf('La ra�z para el polinomio entregado es %f\n', raiz);