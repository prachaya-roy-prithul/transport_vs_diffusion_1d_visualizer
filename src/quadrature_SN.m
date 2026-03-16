function [mu, w] = quadrature_SN(SN)
%QUADRATURE_SN Generate Gauss-Legendre quadrature points and weights on [-1, 1].

n = SN;
beta = 0.5 ./ sqrt(1.0 - (2.0 * (1:n-1)).^(-2));
T = diag(beta, 1) + diag(beta, -1);
[V, D] = eig(T);

mu = diag(D);
[mu, idx] = sort(mu);
V = V(:, idx);

w = 2.0 * (V(1, :) .^ 2);
mu = mu(:);
w = w(:);
end