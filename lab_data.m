function d = lab_data()
% Одни и те же сигналы во всех заданиях, даже при отдельном запуске файлов.
cfg = lab_config();
oldRng = rng;
restoreRng = onCleanup(@() rng(oldRng)); %#ok<NASGU>
rng(cfg.seed, 'twister');
d.x = randi(cfg.range, cfg.N, 1);
d.y = randi(cfg.range, cfg.N, 1);
d.N = cfg.N;
d.n = (0:cfg.N-1).';
d.W = dft_matrix(cfg.N);
d.Winv = conj(d.W)/cfg.N;
d.X = d.W*d.x;
end
