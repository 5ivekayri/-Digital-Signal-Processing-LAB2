function r = task2()
% Задание 2: спектр матричным ДПФ; fft используется только для проверки.
d = lab_data(); cfg = lab_config();
r.X = d.X; r.amplitude = abs(d.X); r.phase = spectrum_phase(d.X);
r.fftError = norm(d.X-fft(d.x),inf);
r.symmetryError = norm(d.X-conj(d.X(mod(-(0:d.N-1),d.N)+1)),inf);
r.multiplications = d.N^2; r.additions = d.N*(d.N-1);
fprintf('\nЗАДАНИЕ 2. Амплитудный и фазовый спектры\n');
disp(table(d.n,real(d.X),imag(d.X),r.amplitude,r.phase, ...
    'VariableNames',{'k','Re_X','Im_X','Magnitude','Phase_rad'}));
fprintf('Прямое суммирование: %d комплексных умножений, %d сложений; O(N^2).\n', ...
    r.multiplications,r.additions);
fprintf('Это формальный счет без упрощений для вещественных x и множителей 1, -1, +/-j.\n');
fprintf('Ошибка относительно fft: %.3e; сопряженная симметрия: %.3e.\n',r.fftError,r.symmetryError);
figure('Name','Task 2 - Spectrum','Color','w','Renderer','painters','Position',[100 100 1000 760]);
subplot(2,1,1); stem(d.n,r.amplitude,'filled'); grid on;
xlabel('k'); ylabel('|X[k]|'); title('Амплитудный спектр (без нормировки)');
subplot(2,1,2); stem(d.n,r.phase,'filled'); grid on;
xlabel('k'); ylabel('arg X[k], рад'); title('Главное значение фазы');
assert(max([r.fftError,r.symmetryError]) < cfg.tol);
end
