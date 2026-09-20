function r = preliminary()
% Подготовка: ортогональность, периодичность, симметрия, мультипликативность.
cfg = lab_config(); N = cfg.preliminaryN;
n = 0:N-1; W = dft_matrix(N);
r.W = W;
r.orthogonality = norm(W*W' - N*eye(N), 'fro'); % ' = сопряженное транспонирование
r.symmetry = norm(W-W.', 'fro');                % .' = обычное транспонирование
r.periodicity = norm(exp(-1i*2*pi/N*((n.'+N)*n))-W, 'fro');
r.multiplicativity = 0;
for a = 0:N-1
    for b = 0:N-1
        err = norm(W(a+1,:).*W(b+1,:) - W(mod(a+b,N)+1,:), inf);
        r.multiplicativity = max(r.multiplicativity,err);
    end
end
fprintf('\nПРЕДВАРИТЕЛЬНОЕ ЗАДАНИЕ, N=%d\n',N);
disp('Матрица прямого ДПФ W:'); disp(W);
disp('W*W'' (должно быть N*I):'); disp(W*W');
fprintf('Ошибки: ортогональность %.3e; периодичность %.3e; симметрия %.3e; мультипликативность %.3e.\n', ...
    r.orthogonality,r.periodicity,r.symmetry,r.multiplicativity);
assert(max([r.orthogonality,r.periodicity,r.symmetry,r.multiplicativity]) < cfg.tol);
end
