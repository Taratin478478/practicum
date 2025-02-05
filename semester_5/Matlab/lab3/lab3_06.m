%% 6
clc; clear; close all;

GenerateTable(20, 20);
SavePrivateRyan(1);
function GenerateTable(n,m)
    P = rand(n, m);
    %P = [0, 1 0, 0, 0; 0, 1 0, 1, 0; 0, 1 0, 1, 0; 0, 1 0, 1, 0; 0, 0, 0, 1, 0];
    fig = figure();
    fig.WindowState = 'maximized';
    imagesc(P);
    ax = gca;
    ax.YDir = 'normal';
    colorbar;
    save("ProbMatrix.mat", "P", "n", "m");
end

function SavePrivateRyan(var)
    load("ProbMatrix.mat", "P", "n", "m");
    Price = zeros(n, m);
    Price(n, m) = 1 - P(n, m);
    NDiff = 1;
    ToCheck = zeros(n, m);
    if n > 1
        ToCheck(n - 1, m) = 1;
        if (m > 1) & (var == 1)
            ToCheck(n - 1, m - 1) = 1;
        end
    end
    if m > 1
        ToCheck(n, m - 1) = 1;
    end
    
    while NDiff > 0 
        NDiff = 0;
        ToCheckNext = zeros(n, m);
        for i = 1:n
            for j = 1:m
                if ToCheck(i, j) == 1
                    MaxPrice = -1;
                    if i < n
                        MaxPrice = max(MaxPrice, Price(i + 1, j));
                    end
                    if i > 1
                        MaxPrice = max(MaxPrice, Price(i - 1, j));
                    end
                    if j < m
                        MaxPrice = max(MaxPrice, Price(i, j + 1));
                    end
                    if j > 1 
                        MaxPrice = max(MaxPrice, Price(i, j - 1));
                    end
                    if (var == 1)
                        if i < n
                            if j < m
                                MaxPrice = max(MaxPrice, Price(i + 1, j + 1));
                            end
                            if j > 1
                                MaxPrice = max(MaxPrice, Price(i + 1, j - 1));
                            end
                        end
                        if i > 1
                            if j < m
                                MaxPrice = max(MaxPrice, Price(i - 1, j + 1));
                            end
                            if j > 1 
                                MaxPrice = max(MaxPrice, Price(i - 1, j - 1));
                            end
                        end
                    end
                    NewPrice = (1 - P(i, j)) * MaxPrice;
                    fprintf("%d %d %f %f\n", i, j, NewPrice, Price(i, j));
                    if NewPrice > Price(i, j)
                        Price(i, j) = NewPrice;
                        NDiff = NDiff + 1;
                        if i < n
                            ToCheckNext(i + 1, j) = 1;
                        end
                        if i > 1
                            ToCheckNext(i - 1, j) = 1;
                        end
                        if j < m
                            ToCheckNext(i, j + 1) = 1;
                        end
                        if j > 1
                            ToCheckNext(i, j - 1) = 1;
                        end
                        if (var == 1)
                            if i < n
                                if j < m
                                    ToCheckNext(i + 1, j + 1) = 1;
                                end
                                if j > 1
                                    ToCheckNext(i + 1, j - 1) = 1;
                                end
                            end
                            if i > 1
                                if j < m
                                    ToCheckNext(i - 1, j + 1) = 1;
                                end
                                if j > 1 
                                    ToCheckNext(i - 1, j - 1) = 1;
                                end
                            end
                        end
                    end
                end 
            end
        end
        ToCheck = ToCheckNext;
    end
    i = 1;
    j = 1;
    hold on;
    Visited = zeros(n, m);
    while i + j < n + m
        MaxPrice = -1;
        if (i < n) & (Price(i + 1, j) > MaxPrice) & (Visited(i + 1, j) == 0)
            MaxPrice = Price(i + 1, j);
            in = i + 1;
            jn = j;
        end
        if (j < m) & (Price(i, j + 1) > MaxPrice) & (Visited(i, j + 1) == 0)
            MaxPrice = Price(i, j + 1);
            in = i;
            jn = j + 1;
        end
        if (i > 1) & (Price(i - 1, j) > MaxPrice) & (Visited(i - 1, j) == 0)
            MaxPrice = Price(i - 1, j);
            in = i - 1;
            jn = j;
        end
        if (j > 1) & (Price(i, j - 1) > MaxPrice) & (Visited(i, j - 1) == 0)
            MaxPrice = Price(i, j - 1);
            in = i;
            jn = j - 1;
        end
        if (var == 1)
            if i < n
                if (j < m) & (Price(i + 1, j + 1) > MaxPrice) & (Visited(i + 1, j + 1) == 0)
                    MaxPrice = Price(i + 1, j + 1);
                    in = i + 1;
                    jn = j + 1;
                end
                if (j > 1) & (Price(i + 1, j - 1) > MaxPrice) & (Visited(i + 1, j - 1) == 0)
                    MaxPrice = Price(i + 1, j - 1);
                    in = i + 1;
                    jn = j - 1;
                end
            end
            if i > 1
                if (j < m) & (Price(i - 1, j + 1) > MaxPrice) & (Visited(i - 1, j + 1) == 0)
                    MaxPrice = Price(i - 1, j + 1);
                    in = i - 1;
                    jn = j + 1;
                end 
                if (j > 1) & (Price(i - 1, j - 1) > MaxPrice) & (Visited(i - 1, j - 1) == 0)
                    MaxPrice = Price(i - 1, j - 1);
                    in = i - 1;
                    jn = j - 1;
                end
            end
        end
        fprintf("%d %d %d %d\n", i, j, in, jn);
        quiver(j,  i + 1/8, jn - j, in - i, "-w", 'Linewidth', 30 / max(n, m));
        Visited(i, j) = 1;
        i = in;
        j = jn;
    end
    for i = 1:m
        for j = 1:n
            text(i, j - 1/8, string(Price(j, i)), 'HorizontalAlignment', 'center', 'Color', 'k', 'FontName', 'Consolas', 'FontSize', 150 / max(n, m), 'FontWeight', 'bold');
        end
    end
    disp("GG")
    hold off;
end