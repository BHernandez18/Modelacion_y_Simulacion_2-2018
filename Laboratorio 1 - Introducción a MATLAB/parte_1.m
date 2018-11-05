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
%

% ===================
% == Primera parte ==
%
% Se solicita graficar las siguientes funciones:
%
% 1) a(x) = 3 * log_5 (3 * x + 1)
% 2) b(x) = sin(2 * (log_2 (x + 11))) + cos(5 * (log_6 (3 * x + 27)))
%
% La primera función debe ser graficada en rojo y con *, la segunda en
% verde y con +, ambas en el intervalo [0, 15pi] con un espacio entre los
% puntos de 0.01

x_1 = 0:.01:15*pi;    % Vector con los puntos a evaluar en la función
a = 3 * (log(3 * x_1 + 1) / log(5));
b = sin(2 * log2(x_1 + 11)) + cos(5 * (log(3 * x_1 + 27) / log(6)));

% Se grafican los puntos obtenidos previamente y se configuran los
% elementos del gráfico resultante.

%
% << Gráfico a(x) >>
%
figure(1);
plot(x_1, a,...
    'Color', 'r', ...
    'Marker', '*', ...
    'MarkerSize', 6);

title({'\textbf{Gr\''afica funci\''on} $a(x) = 3 \cdot log_5 (3x + 1)$'},...
    'Interpreter','latex');
xlabel('x');
ylabel('a(x)');
saveas(gcf, 'grafico_a(x).png');

%
% << Gráfico b(x) >>
%
figure(2);
plot(x_1, b,...
    'Color', 'g', ...
    'Marker', '+', ...
    'MarkerSize', 6);

title({'\textbf{Gr\''afica funci\''on} $b(x) = sin(2 log_2 (x + 11)) + cos(5 log_6 (3x + 27))$'},...
    'Interpreter','latex');
xlabel('x');
ylabel('b(x)');
saveas(gcf, 'grafico_b(x).png');

%
% << Gráfico a(x) y b(x) juntos >>
%
figure(3);
plot(x_1, a, ...
    'Color', 'r', ...
    'Marker', '*', ...
    'MarkerSize', 6);
hold on;
plot(x_1, b, ...
    'Color', 'g', ...
    'Marker', '+', ...
    'MarkerSize', 6)
hold off;
title({'\textbf{Gr\''afica funciones} $a(x)$ y $b(x)$'},...
    'Interpreter', 'latex');
xlabel('x');
legend('a(x)', 'b(x)');
saveas(gcf, 'grafico_a(x)_y_b(x).png');

%
% A continuación, se solicita graficar en escala normal y logarítmica la
% siguiente función:
%
% c(x) = 2 * e^(x + 10)
%
% El gráfico puede tener un color y estilo de linea a elección, pero debe
% incluir la figura cuadriculada (presencencia de grilla) en el intervalo
% [-10, 10] con un espaciado 0.05.
%

x_2 = -10:.05:10;    % Vector con los puntos a evaluar en la función
c = 2 * exp(x_2 + 10);

% Se grafican los puntos obtenidos previamente y se configuran los
% elementos del gráfico resultante.

%
% << Gráfico c(x) con escala normal >>
%
figure(4);
plot(x_2, c, ...
    'Color', 'b', ...
    'Marker', 'x', ...
    'MarkerSize', 6);
title({'\textbf{Gr\''afica funci\''on} $c(x) = 2 \cdot e^{x + 10}$ [escala normal]'}, ...
    'Interpreter', 'latex');
xlabel('x')
ylabel('c(x)')
grid on;
saveas(gcf, 'grafico_c(x)_normal.png');

%
% << Gráfico c(x) con escala logaritmica >>
%
figure(5);
semilogy(x_2, c, ...
    'Color', 'b', ...
    'Marker', 'x', ...
    'MarkerSize', 6);
title({'\textbf{Gr\''afica funci\''on} $c(x) = 2 \cdot e^{x + 10}$ [escala logaritmica]'}, ...
    'Interpreter', 'latex');
xlabel('x');
ylabel('c(x)');
grid on;
saveas(gcf, 'grafico_c(x)_logaritmica.png');