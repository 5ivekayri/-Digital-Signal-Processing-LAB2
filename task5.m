function r = task5()
% Задание 5: четный, нечетный и чисто мнимый сигналы.
% В методичке нечетная последовательность имеет 7 элементов, а не 8.
% Рассматриваем ее буквально (N=7) и отдельно согласованный случай N=8.
d = lab_data(); cfg = lab_config(); x = d.x;
even8 = [x(1:5); x(4:-1:2)];
odd7 = [0; x(2:4); -x(4:-1:2)];       % Буквальная формула со стр. 76 PDF.
odd8 = [0; x(2:4); 0; -x(4:-1:2)];    % Для N=8 обязательно x[4]=0.
imaginary8 = 1i*x;
signals = {even8,odd7,odd8,imaginary8};
labels = {'Четный сигнал, N=8','Нечетный по методичке, N=7', ...
          'Нечетный с нулем в середине, N=8','Чисто мнимый сигнал, N=8'};
r.signals = signals; r.spectra = cell(size(signals));
fprintf('\nЗАДАНИЕ 5. Симметрия и тип отсчетов\n');
for t = 1:numel(signals)
    s = signals{t}; N = length(s); k = (0:N-1).';
    S = dft_matrix(N)*s; r.spectra{t} = S;
    fprintf('%s: ',labels{t}); fprintf('%g%+gi ',[real(s),imag(s)].'); fprintf('\n');
    figure('Name',sprintf('Task 5.%d',t),'Color','w','Renderer','painters','Position',[100 100 1000 760]);
    subplot(2,2,1); stem(k,real(s),'filled'); hold on; stem(k,imag(s),'r');
    grid on; xlabel('n'); ylabel('s[n]'); title(labels{t}); legend('Re s','Im s');
    subplot(2,2,2); stem(k,real(S),'filled'); hold on; stem(k,imag(S),'r');
    grid on; xlabel('k'); ylabel('S[k]'); title('Комплексный спектр'); legend('Re S','Im S');
    subplot(2,2,3); stem(k,abs(S),'filled'); grid on; xlabel('k'); ylabel('|S[k]|'); title('Модуль');
    subplot(2,2,4); stem(k,spectrum_phase(S),'filled'); grid on;
    xlabel('k'); ylabel('arg S[k], рад'); title('Фаза; при |S|=0 не определена');
end
r.evenError = norm(imag(r.spectra{1}),inf);
r.odd7Error = norm(real(r.spectra{2}),inf);
r.odd8Error = norm(real(r.spectra{3}),inf);
r.imaginaryError = norm(r.spectra{4}-1i*d.X,inf);
reverse = mod(-(0:d.N-1),d.N)+1;
r.antiConjugateError = norm(r.spectra{4}+conj(r.spectra{4}(reverse)),inf);
fprintf('Четный вещественный сигнал: max|Im S| = %.3e.\n',r.evenError);
fprintf('Нечетные сигналы N=7 и N=8: max|Re S| = %.3e, %.3e.\n',r.odd7Error,r.odd8Error);
fprintf('F{j*x}=j*X: ошибка %.3e; антисопряженная симметрия: %.3e.\n',r.imaginaryError,r.antiConjugateError);
fprintf('Умножение на j сохраняет модуль, прибавляет pi/2 к фазе по модулю 2*pi.\n');
assert(max([r.evenError,r.odd7Error,r.odd8Error,r.imaginaryError,r.antiConjugateError]) < cfg.tol);
end
