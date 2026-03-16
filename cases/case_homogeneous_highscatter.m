function p = case_homogeneous_highscatter()
%CASE_HOMOGENEOUS_HIGHSCATTER Define a homogeneous highly scattering slab case.

p.name = 'homogeneous_highscatter';

p.L = 10.0;
p.Nx = 100;

p.SN = 8;
p.max_iter = 500;
p.tol = 1e-8;

p.bc_left = 'vacuum';
p.bc_right = 'vacuum';

p.xs.Sigma_t = @(x) 1.0 + 0*x;
p.xs.Sigma_s = @(x) 0.9 + 0*x;
p.src.Q_iso = @(x) 1.0 * exp(-((x - 5.0).^2) / 0.2);

p.results_dir = 'results';
end