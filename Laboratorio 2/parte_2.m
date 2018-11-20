%
% Laboratorio 2 - Modelación y Simulación
% << Análisis de sistemas >>
%
% Integrantes:  Pablo Cáceres Luzanto
%               Benjamín Hernández Cortés
%
% Fecha: 22 de noviembre de 2018
% Profesor: Gonzalo Acuña
% Ayudante: Francisco Muñoz
%

% ===================
% == Segunda parte ==
%
% Se solicita graficar la respuesta al escalón para el diagrama de bloque
% mostrado en el enunciado.
%
% Funciones de Transferencia asociadas.
% -------------------------------------
H1 = tf([0 4 0], [5 0 2]);      %     4s / 5s^2 + 2
H2 = tf([0 4], [1 6]);          %      4 / s + 6
H3 = tf([0 0 1 1], [3 5 0 0]);  %  s + 1 / 3s^3 + 5s^2
H4 = tf([0 1], [7 4]);          %      1 / 7s + 4
H5 = tf([0 0 5 4], [5 1 0 4]);  % 5s + 4 / 5s^3 + s^2 + 4
H6 = tf([0 0 1 3], [1 6 0 5]);  % 2s + 3 / s^3 + 6s^2 + 5

% Obtención del diagrama de bloque asociado.
% ------------------------------------------
% Sistemas en Paralelo - Función 4 y 5
H45 = parallel(H4, H5);

% Retroalimentación - Función 3
H3F = feedback(H3, 1, +1);

% Sistemas en Serie - H3F y H45 
H345 = series(H3F, H45);

% Sistemas en Serie - H345 y Función 6
H3456 = series(H345, H6);

% Sistemas en Paralelo - Función 1 y 2
H12 = parallel(H1, H2);

% Sistemas en Paralelo - H12 y H3456
Hfinal = parallel(H12, H3456);

% ===========================
% == Obtención de gráficos ==

%
% >> Función de Transferencia Hfinal(s) <<
%
figure(1);
step(Hfinal);
title({'\textbf{Respuesta al impulso para} $H_{final}(s)$'},...
    'Interpreter','latex',...
    'FontSize', 13);
xlabel('Tiempo');
ylabel('Amplitud');
grid on;
saveas(gcf, 'grafico_Hfinal.png');

% ==================================================
% == Polinomios de las funciones de transferencia ==

% Sistemas en Paralelo - Función 4 y 5
[num, den] = tfdata(H45, 'v');
fprintf("H45(s) = %s / %s\n\n", poly2sym(num), poly2sym(den));

% Retroalimentación - Función 3
[num, den] = tfdata(H3F, 'v');
fprintf("H3F(s) = %s / %s\n\n", poly2sym(num), poly2sym(den));

% Sistemas en Serie - H3F y H45 
[num, den] = tfdata(H345, 'v');
fprintf("H345(s) = %s / %s\n\n", poly2sym(num), poly2sym(den));

% Sistemas en Serie - H345 y Función 6
[num, den] = tfdata(H3456, 'v');
fprintf("H3456(s) = %s / %s\n\n", poly2sym(num), poly2sym(den));

% Sistemas en Paralelo - Función 1 y 2
[num, den] = tfdata(H12, 'v');
fprintf("H12(s) = %s / %s\n\n", poly2sym(num), poly2sym(den));

% Sistemas en Paralelo - H12 y H3456
[num, den] = tfdata(Hfinal, 'v');
fprintf("Hfinal(s) = %s / %s\n", poly2sym(num), poly2sym(den));