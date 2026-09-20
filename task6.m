function r = task6()
% Задание 6: сдвиг вправо x_m[n]=x[(n-m) mod N].
% X_m[k]=X[k]*exp(-j*2*pi*k*m/N). Фазы сравниваем по модулю 2*pi.
d = lab_data(); cfg = lab_config(); r = struct([]);
fprintf('\nЗАДАНИЕ 6. Циклический сдвиг\n');
for t = 1:numel(cfg.shifts)
    m = cfg.shifts(t); s = circshift(d.x,m);
    S = d.W*s; predicted = d.X.*exp(-1i*2*pi*d.n*m/d.N);
    r(t).shift = m; r(t).signal = s; r(t).spectrum = S;
    r(t).spectrumError = norm(S-predicted,inf);
    r(t).amplitudeError = norm(abs(S)-abs(d.X),inf);
    valid = abs(d.X) > cfg.tol*max(1,max(abs(d.X)));
    phaseResidual = angle(exp(1i*(angle(S(valid))-angle(d.X(valid))+2*pi*d.n(valid)*m/d.N)));
    r(t).phaseError = max([0;abs(phaseResidual)]);
    fprintf('Сдвиг %d: ошибка спектра %.3e; модуля %.3e; фазы %.3e рад.\n', ...
        m,r(t).spectrumError,r(t).amplitudeError,r(t).phaseError);
    figure('Name',sprintf('Task 6 - Shift %d',m),'Color','w','Renderer','painters','Position',[100 100 1000 760]);
    subplot(3,1,1); stem(d.n,d.x,'filled'); hold on; plot(d.n,s,'ro-'); grid on;
    xlabel('n'); ylabel('x[n]'); title(sprintf('Сдвиг вправо на %d отсчетов',m)); legend('Исходный','Сдвинутый');
    subplot(3,1,2); stem(d.n,abs(d.X),'filled'); hold on; plot(d.n,abs(S),'rx','MarkerSize',10); grid on;
    xlabel('k'); ylabel('|X[k]|'); title('Модуль спектра сохраняется'); legend('Исходный','Сдвинутый');
    subplot(3,1,3); stem(d.n,spectrum_phase(S),'filled'); hold on;
    plot(d.n,spectrum_phase(predicted),'rx','MarkerSize',10); plot(d.n,spectrum_phase(d.X),'k:'); grid on;
    xlabel('k'); ylabel('Фаза, рад'); title('Фаза изменяется по закону сдвига (mod 2*pi)');
    legend('После сдвига','Теория','Исходный');
    assert(max([r(t).spectrumError,r(t).amplitudeError,r(t).phaseError]) < cfg.tol);
end
end
