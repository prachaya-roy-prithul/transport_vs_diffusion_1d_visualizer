clear;
clc;
close all;

addpath('src');
addpath('cases');
addpath('plots_script');

% p = case_homogeneous_highscatter();
% p = case_homogeneous_moderate();
p = case_two_region();

if ~exist(p.results_dir, 'dir')
    mkdir(p.results_dir);
end

d = setup_problem(p);

out = source_iteration(d, p);
terms = compute_terms(d, out);
diff_out = solve_diffusion(d);
bal = neutron_balance(d, out);

plot_scalar_flux(d, out, diff_out, p);
plot_angular_flux(d, out, p);
plot_terms(d, terms, p);
plot_residual(out, terms, d, p);
plot_diffusion_error(d, out, diff_out, p);

disp('--- Run summary ---');
disp(['Case: ', p.name]);
disp(['Converged: ', num2str(out.converged)]);
disp(['Iterations: ', num2str(out.n_iter)]);
disp(['Source total: ', num2str(bal.source)]);
disp(['Absorption total: ', num2str(bal.absorption)]);
disp(['Left leakage: ', num2str(bal.left_leakage)]);
disp(['Right leakage: ', num2str(bal.right_leakage)]);
disp(['Balance error: ', num2str(bal.balance_error)]);