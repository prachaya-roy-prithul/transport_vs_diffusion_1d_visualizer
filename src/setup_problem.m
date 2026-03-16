function d = setup_problem(p)
%SETUP_PROBLEM Construct mesh, material arrays, source arrays, and quadrature data.

d.x_edges = linspace(0.0, p.L, p.Nx + 1);
d.x_centers = 0.5 * (d.x_edges(1:end-1) + d.x_edges(2:end));
d.dx = diff(d.x_edges);

d.Sigma_t = p.xs.Sigma_t(d.x_centers);
d.Sigma_s = p.xs.Sigma_s(d.x_centers);
d.Sigma_a = d.Sigma_t - d.Sigma_s;

d.Q_iso = p.src.Q_iso(d.x_centers);
d.Q_ang = 0.5 * d.Q_iso;

[d.mu, d.w] = quadrature_SN(p.SN);

d.Nmu = numel(d.mu);
d.Nx = p.Nx;
end