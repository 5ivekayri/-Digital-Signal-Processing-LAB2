function W = dft_matrix(N)
% W(k+1,n+1)=exp(-j*2*pi*k*n/N). Индексы ДПФ начинаются с нуля.
validateattributes(N, {'numeric'}, {'scalar','integer','positive'});
n = 0:N-1;
W = exp(-1i*2*pi/N * (n.' * n));
end
