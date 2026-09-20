function r = task1()
% Задание 1: случайная целочисленная последовательность длины 8.
d = lab_data(); r = d;
fprintf('\nЗАДАНИЕ 1. Исходная последовательность, N=%d\n',d.N);
disp(table(d.n,d.x,'VariableNames',{'n','x'}));
disp('Матрица прямого ДПФ W:'); disp(d.W);
disp('Матрица обратного ДПФ conj(W)/N:'); disp(d.Winv);
figure('Name','Task 1 - Signal','Color','w','Renderer','painters','Position',[100 100 1000 760]);
stem(d.n,d.x,'filled'); grid on; xlabel('n'); ylabel('x[n]');
title('Случайный вещественный сигнал'); xticks(d.n);
end
