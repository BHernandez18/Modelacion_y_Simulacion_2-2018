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

% ========================
% == Segunda parte - a) ==

% Se solicita implementar el algoritmo de Newton-Raphson y que entregue
% como resultado una raíz de una función dada o una aproximación de ella.
% Se debe considerar que la función será de una sola variable, y que será
% dada por consola en formato de polinomio.

polinomio = input('Ingrese el polinomio en formato vector [x1,...,xn]: ');
max_iteraciones = input('Defina la cantidad maxima de iteraciones a realizar (ej. 100): ');
error = input('Defina el error minimo aceptable (ej. 10^-5): ');
x_0 = input('Defina el punto inicial para el método: ');

%
% Llamada a la función de Newton-Raphson implementada.
%
raiz = newton_raphson(polinomio, max_iteraciones, error, x_0);

%
% Visualización del resultado
%
fprintf('La raíz para el polinomio entregado es %f\n', raiz);