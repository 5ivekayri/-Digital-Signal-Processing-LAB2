function r = task4()
% Задание 4: F{a*x+b*y}=a*F{x}+b*F{y}.
d = lab_data(); cfg = lab_config();
a = 2; b = -0.5;
r.x = d.x; r.y = d.y; r.a = a; r.b = b;
r.left = d.W*(a*d.x+b*d.y);
r.right = a*(d.W*d.x)+b*(d.W*d.y);
r.error = norm(r.left-r.right,inf);
fprintf('\nЗАДАНИЕ 4. Линейность, a=%g, b=%g\n',a,b);
disp(table(d.n,d.x,d.y,'VariableNames',{'n','x','y'}));
fprintf('max|F(a*x+b*y)-(a*F(x)+b*F(y))| = %.3e\n',r.error);
figure('Name','Task 4 - Linearity','Color','w','Renderer','painters','Position',[100 100 1000 760]);
subplot(2,1,1); stem(d.n,real(r.left),'filled'); hold on;
plot(d.n,real(r.right),'rx','MarkerSize',10); grid on;
xlabel('k'); ylabel('Re'); title('Линейность: действительная часть'); legend('F(a*x+b*y)','a*F(x)+b*F(y)');
subplot(2,1,2); stem(d.n,imag(r.left),'filled'); hold on;
plot(d.n,imag(r.right),'rx','MarkerSize',10); grid on;
xlabel('k'); ylabel('Im'); title('Линейность: мнимая часть');
assert(r.error < cfg.tol);
end
