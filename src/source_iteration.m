function out = source_iteration(d, p)
%SOURCE_ITERATION Solve the fixed-source transport problem by source iteration.

phi = zeros(d.Nx, 1);
res_hist = zeros(p.max_iter, 1);

for it = 1:p.max_iter
    scatter_source = 0.5 * d.Sigma_s(:) .* phi;

    psi = sweep_transport(d, scatter_source.');

    phi_new = (d.w.' * psi).';

    rel_change = norm(phi_new - phi, 2) / max(norm(phi_new, 2), 1e-14);
    res_hist(it) = rel_change;

    phi = phi_new;

    if rel_change < p.tol
        break;
    end
end

out.psi = psi;
out.phi = phi.';
out.scatter_source = 0.5 * d.Sigma_s .* out.phi;
out.res_hist = res_hist(1:it);
out.n_iter = it;
out.converged = (res_hist(it) < p.tol);
end