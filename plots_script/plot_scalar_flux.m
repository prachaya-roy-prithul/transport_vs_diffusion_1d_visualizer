function plot_scalar_flux(d, out, diff_out, p)
%PLOT_SCALAR_FLUX Plot transport and diffusion scalar flux.

f = figure('Name', 'Scalar Flux');
plot(d.x_centers, out.phi, 'LineWidth', 1.5); hold on;
plot(d.x_centers, diff_out.phi, '--', 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('\phi(x)');
title(['Scalar Flux Comparison: ', p.name], 'Interpreter', 'none');
legend('Transport', 'Diffusion', 'Location', 'best');

saveas(f, fullfile(p.results_dir, ['scalar_flux_', p.name, '.png']));
end