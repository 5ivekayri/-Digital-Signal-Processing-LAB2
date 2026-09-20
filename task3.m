function r = task3()
% Задание 3: восстановление двумя способами. Q меняет k на (-k) mod N.
d = lab_data(); cfg = lab_config();
indices = mod(-(0:d.N-1),d.N)+1;
Q = eye(d.N); Q = Q(indices,:);
r.Q = Q;
r.inverse = d.Winv*d.X;
r.permutation = d.W*(Q*d.X)/d.N;
r.inverseError = norm(r.inverse-d.x,inf);
r.permutationError = norm(r.permutation-d.x,inf);
r.matrixError = norm(d.W*d.W-d.N*Q,'fro');
fprintf('\nЗАДАНИЕ 3. Обратное ДПФ\n');
disp('Матрица перестановок Q:'); disp(Q);
disp(table(d.n,d.x,real(r.inverse),real(r.permutation), ...
    'VariableNames',{'n','Original','InverseDFT','ViaQ'}));
fprintf('Ошибки восстановления: %.3e и %.3e; W^2=N*Q: %.3e.\n', ...
    r.inverseError,r.permutationError,r.matrixError);
fprintf('Малые мнимые части сохранены при проверке, а в таблице показаны действительные части.\n');
assert(max([r.inverseError,r.permutationError,r.matrixError]) < cfg.tol);
end
