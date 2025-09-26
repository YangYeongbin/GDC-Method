% data
tolerance = [1e-2, 1e-3, 1e-4, 1e-5, 1e-6];
error_percent = [0.2703, 0.2614, 0.2667, 0.0024, 0.0];
avg_iterations = [1.902667, 1.988659, 2.067333, 2.776596, 2.916888];

% figure
figure;
yyaxis left
semilogx(tolerance, error_percent, '-o', 'LineWidth', 1.5, 'MarkerSize', 7, 'Color', [0.85 0.33 0.10])
ylabel('Error (%)', 'FontName', 'Times New Roman', 'FontSize', 12)
ylim([-0.05, max(error_percent)*1.2])
set(gca, 'YColor', [0.85 0.33 0.10])

yyaxis right
semilogx(tolerance, avg_iterations, '--s', 'LineWidth', 1.5, 'MarkerSize', 7, 'Color', [0 0.45 0.74])
ylabel('Average Number of Iterations', 'FontName', 'Times New Roman', 'FontSize', 14)
ylim([1.5, max(avg_iterations)*1.2])
set(gca, 'YColor', [0 0.45 0.74])

% parameter setting
xlabel('Tolerance (log scale)', 'FontName', 'Times New Roman', 'FontSize', 14)
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
grid on
box on
