function fig = renderBacteriaPaths(boundary, x, y)
    %  RENDERBACTERIAPATHS(X, Y)
    %
    % Render the billiard-bacteria bouncing problem paths

    % Generate figure
    fig = figure('Name', 'Bacterial Billiards');

    line(boundary(1, :), boundary(2, :), 'color', [0.1, 0.1, 0.1], 'LineWidth', PlotDefaults.std.LineWidth);
    hold on

    % Generate lines (add options for colours here)
    line(x, y, 'color', PlotDefaults.colours.blue(10, :), 'LineWidth', PlotDefaults.std.LineWidth);
    
    
    % Generate scatter points for collision emphasis:
    warning('Following will produce colour ERRORS for length(x, y) <= 3');
    
    % INITIAL POINT
    scatter(x(1), y(1), 'color', PlotDefaults.colours.blue(7, :), 'LineWidth', 0.875*PlotDefaults.std.LineWidth);

    % SUBSEQUENT POINTS
    scatter(x(2:end - 1), y(2:end - 1), 'color', PlotDefaults.colours.red(7, :), 'LineWidth', 0.875*PlotDefaults.std.LineWidth);

    % FINAL POINT
    scatter(x(end), y(end), 'color', PlotDefaults.colours.orange(7, :), 'LineWidth', 0.875*PlotDefaults.std.LineWidth);

    PlotDefaults.applyDefaultLabels;
    PlotDefaults.setLatexDefault;

    % Plot options here
    hold off
    axis equal
end