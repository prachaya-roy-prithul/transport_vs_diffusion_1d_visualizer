function p = case_two_region()
%CASE_TWO_REGION Define a heterogeneous two-region slab case.

p.name = 'two_region';

p.L = 10.0;
p.Nx = 120;

p.SN = 8;
p.max_iter = 500;
p.tol = 1e-8;

p.bc_left = 'vacuum';
p.bc_right = 'vacuum';

p.xs.Sigma_t = @(x) (x < 5.0).*0.6 + (x >= 5.0).*1.4;
p.xs.Sigma_s = @(x) (x < 5.0).*0.5 + (x >= 5.0).*1.1;
p.src.Q_iso = @(x) 1.0 * exp(-((x - 3.0).^2) / 0.15);

p.results_dir = 'results';
end