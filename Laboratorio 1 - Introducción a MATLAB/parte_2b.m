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
% == Segunda parte - b) ==

% Se solicita crear un archivo .m que reciba como entrada un vector y
% despliegue por pantalla el resultado de la ra�z cuadrada de la suma de
% los 4 elementos de mayor valor, menos el resultado de la suma de la ra�z
% cuadrada de los 4 elementos de menor valor.

vector = [];
i = 1;

%
% Petici�n del largo del vector a generar.
%
while true
    % Se pide el ingreso del largo del vector a generar.
    largo = input('Ingrese el largo del vector a generar con un numero entero (mayor o igual a 4): ', 's');
    % Se verifica que el largo ingresado sea un valor num�rico.
    if isnan(str2double(largo))
        fprintf('ERROR: El dato ingresado no es numerico. Por favor, ingrese un valor numerico.\n');
    % Se verifica que el largo ingresado sea un n�mero entero.
    elseif mod(str2double(largo), 1) ~= 0
        fprintf('ERROR: El dato ingresado no es un numero entero. Por favor, ingrese un numero entero.\n');
    % Se verifica que el largo del vector sea al menos 4.
    elseif str2double(largo) < 4
        fprintf('ERROR: El largo ingresado es menor que 4. Por favor, ingrese un largo mayor\n');
    else
        largo = str2double(largo);
        break;
    end
end

%
% Inserci�n de los n�meros al vector.
%
while i <= largo
    mensaje = join(['Ingrese el dato ', num2str(i), ': ']);
    dato = input(mensaje, 's');
    % Se verifica que el dato a ingresar en el vector sea num�rico.
    if isnan(str2double(dato))
        fprintf('ERROR: El dato ingresado no es numerico. Por favor, ingrese un valor numerico.\n');
    else
        vector = [vector, str2double(dato)];
        i = i + 1;
    end
end

% Se ordena el vector con los n�meros de forma ascendente
vector = sort(vector, 'ascend');

% Se calculan los t�rminos de la resta a realizar.
primer_termino = sqrt(sum(vector(end-3:end)));
segundo_termino = sum(sqrt(vector(1:4)));

%
% Visualizaci�n del resultado
%
fprintf('El resultado es %f\n', primer_termino - segundo_termino);
