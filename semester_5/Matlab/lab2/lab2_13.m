%% 13
viewPossible([0, 2; 2, 0; 0.5, 0.5]', 0.8, 1);
viewPossible([0, 2; 2, 0]', 1, 1);
viewPossible([0, 2; 2, 0; 0, 0; 2, 2; 1, -1; -1, 1; 3, 1; 1, 3]', 0.3336, 1);

function viewPossible(points, V, L)
    N = size(points, 2);
    n = 50;
    maxx = max(points(1, :));
    minx = min(points(1, :));
    maxy = max(points(2, :));
    miny = min(points(2, :));
    dx = abs(maxx - minx);
    dy = abs(maxy - miny);
    [X, Y] = meshgrid(linspace(minx - 0.5* dx, maxx + 0.5 * dx, n), linspace(miny - 0.5 * dy, maxy + 0.5 * dy, n));
    Z = zeros(n, n);
    G = zeros(n, n, 2);
    G(:, :, 1) = X;
    G(:, :, 2) = Y;
    for i = 1:N
        Z = addPoint(Z, points(:, i), V, G);
    end
    %figure;
    %surf(X, Y, Z);
    figure;
    contourf(X, Y, Z - L, [0, 0]);
    F = Z - L >= 0;
    connStats = bwconncomp(F);
    if connStats.NumObjects ~= 1
        disp('Area is not simply connected.');
        return;
    end
    stats = regionprops(F, 'Area', 'FilledArea');
    if all([stats.Area] == [stats.FilledArea])
        disp('Area is simply connected.');
    else
        disp('Area is not simply connected.');
    end
end

function Z = addPoint(Z, p, V, G)
    p = reshape(p, [1, 1, 2]);
    Z = Z + V ./ (1 + vecnorm(G - p, 2, 3));
end