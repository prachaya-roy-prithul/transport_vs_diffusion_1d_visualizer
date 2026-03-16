function plot_angular_flux(d, out, p)
%PLOT_ANGULAR_FLUX Plot selected angular flux profiles.

f = figure('Name', 'Angular Flux');
idx = [1, round(d.Nmu/4), round(3*d.Nmu/4), d.Nmu];
idx = unique(max(min(idx, d.Nmu), 1));

hold on;
for k = 1:numel(idx)
    m = idx(k);
    plot(d.x_centers, out.psi(m, :), 'LineWidth', 1.3, ...
        'DisplayName', ['\mu = ', num2str(d.mu(m), '%.3f')]);
end
grid on;
xlabel('x');
ylabel('\psi(x,\mu)');
title(['Selected Angular Fluxes: ', p.name], 'Interpreter', 'none');
legend('Location', 'best');

saveas(f, fullfile(p.results_dir, ['angular_flux_', p.name, '.png']));
end