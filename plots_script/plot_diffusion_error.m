function plot_diffusion_error(d, out, diff_out, p)
%PLOT_DIFFUSION_ERROR Plot transport-diffusion error measures.

err = out.phi - diff_out.phi;
rel_err = err ./ max(abs(out.phi), 1e-12);

f = figure('Name', 'Diffusion Error');
plot(d.x_centers, err, 'LineWidth', 1.5); hold on;
plot(d.x_centers, rel_err, '--', 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('Error');
title(['Transport-Diffusion Error: ', p.name], 'Interpreter', 'none');
legend('Absolute error', 'Relative error', 'Location', 'best');

saveas(f, fullfile(p.results_dir, ['diffusion_error_', p.name, '.png']));
end