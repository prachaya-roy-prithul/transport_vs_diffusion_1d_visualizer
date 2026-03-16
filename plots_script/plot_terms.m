function plot_terms(d, terms, p)
%PLOT_TERMS Plot discrete transport terms for one selected direction.

[~, m] = min(abs(d.mu - 0.577));

f = figure('Name', 'Transport Terms');
plot(d.x_centers, terms.streaming(m, :), 'LineWidth', 1.4); hold on;
plot(d.x_centers, terms.removal(m, :), 'LineWidth', 1.4);
plot(d.x_centers, terms.scatter(m, :), 'LineWidth', 1.4);
plot(d.x_centers, terms.source(m, :), 'LineWidth', 1.4);
grid on;
xlabel('x');
ylabel('Term value');
title(['Transport Terms for \mu = ', num2str(d.mu(m), '%.3f')], 'Interpreter', 'tex');
legend('Streaming', 'Removal', 'Scatter', 'Source', 'Location', 'best');

saveas(f, fullfile(p.results_dir, ['terms_', p.name, '.png']));
end