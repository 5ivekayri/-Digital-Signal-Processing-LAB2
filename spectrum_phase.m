function phase = spectrum_phase(X)
% Фаза при нулевой амплитуде не определена: не изображаем численный шум.
cfg = lab_config();
phase = angle(X);
phase(abs(X) < cfg.tol*max(1,max(abs(X)))) = NaN;
end
