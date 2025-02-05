%% 14
params.lb = -2;
params.rb = 2;
params.ndots = 50;
params.color = 'c';
params.edge = 'none';
drawBall(1, 1, params);

%% 15
drawManyBalls([0.5, 1, 2, Inf], ['r', 'g', 'b', 'm'], ["none", "none", "none", "none"])
%%
function drawManyBalls(alphas, colors, edges)
    params.lb = -2;
    params.rb = 2;
    params.ndots = 100;
    for i = 1:size(alphas, 2)
        figure;
        params.color = colors(i);
        params.edge = edges(i);
        drawBall(alphas(i), 1, params);
    end
end

function drawBall(alpha, level, params)
    if isinf(alpha)
        f = @(x, y, z) max(max(abs(x), abs(y)), abs(z));
    else
        f = @(x, y, z) abs(x) .^ alpha + abs(y) .^ alpha + abs(z) .^ alpha;
    end
    [X, Y, Z] = meshgrid(linspace(params.lb, params.rb, params.ndots));
    W = f(X, Y, Z);
    if ~any(W)
        disp('ball is empty');
        return;
    end
    
    s = isosurface(X, Y, Z, W, level);
    p = patch(s);
    isonormals(X,Y,Z,W,p);
    view(3);
    
    if isfield(params, 'color')
        set(p,'FaceColor', params.color);
    end
    if isfield(params, 'edge')
        set(p,'EdgeColor', params.edge);
    else
        set(p,'EdgeColor','none');
    end
    camlight;
    lighting gouraud;
end
