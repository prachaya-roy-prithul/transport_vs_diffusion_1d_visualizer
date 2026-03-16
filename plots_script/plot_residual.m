function plot_residual(out, terms, d, p)
%PLOT_RESIDUAL Plot source-iteration residual history and equation residual map.

f1 = figure('Name', 'Iteration Residual');
semilogy(1:numel(out.res_hist), out.res_hist, 'LineWidth', 1.5);
grid on;
xlabel('Iteration');
ylabel('Relative change');
title(['Source Iteration Convergence: ', p.name], 'Interpreter', 'none');

saveas(f1, fullfile(p.results_dir, ['iter_residual_', p.name, '.png']));

f2 = figure('Name', 'Equation Residual');
imagesc(d.x_centers, d.mu, terms.residual);
set(gca, 'YDir', 'normal');
colorbar;
xlabel('x');
ylabel('\mu');
title(['Discrete Transport Residual Map: ', p.name], 'Interpreter', 'none');

saveas(f2, fullfile(p.results_dir, ['equation_residual_', p.name, '.png']));
end