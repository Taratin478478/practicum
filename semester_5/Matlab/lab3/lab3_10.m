clc; clear; close all;


hFigure = figure;
hFigure.WindowState = 'maximized';
subplot(2, 1, 1);
ax1 = gca;
subplot(2, 1, 2);
ax2 = gca;

SPlotInfo = struct;
SPlotInfo.ax1 = ax1;
SPlotInfo.ax2 = ax2;
SPlotInfo.limits = [];
set(hFigure, 'UserData' ,SPlotInfo);
plotFT(hFigure, @(t) sin(5*t) + cos(10*t), [], 1/800, [0, 100], [0, 20]);

hFigure1 = figure;
hFigure1.WindowState = 'maximized';
plotFT(hFigure1, @func1, @ftfunc1, 1/100, [-100, 100], [-1/2, 3]);

hFigure2 = figure;
hFigure2.WindowState = 'maximized';
plotFT(hFigure2, @func2, @ftfunc2, 1/100, [-100, 100], [-10, 100]);

hFigure3 = figure;
hFigure3.WindowState = 'maximized';
plotFT(hFigure3, @func3, [], 1/100, [-100, 100], []);
hFigure4 = figure;
hFigure4.WindowState = 'maximized';
plotFT(hFigure4, @func4, [], 1/100, [-100, 100], []);
%% aliasing
hFigure5 = figure;
hFigure5.WindowState = 'maximized';
outInfo = plotFT(hFigure5, @(t) exp(-t.^2./2), [], 1, [-100, 100], [-10, 10]);
F =  @(l) exp(-l.^2./2) * sqrt(2 * pi);

l = outInfo.outLimVec(1):outInfo.lstep:outInfo.outLimVec(2);
L = 2 * pi / outInfo.step;

hold(outInfo.ax1, 'on');
hold(outInfo.ax2, 'on');
for i = -10:10
    plot(outInfo.ax1, l, real(F(l - L*i)), 'r');
    plot(outInfo.ax2, l, imag(F(l - L*i)), 'r');
end
hold(outInfo.ax1, 'off');
hold(outInfo.ax2, 'off');
legend(outInfo.ax1, 'hide');
legend(outInfo.ax2, 'hide');
%%

function outInfo = plotFT(hFigure, fHandle, fFTHandle, step, inpLimVec, outLimVec)
    outInfo = struct;
    outInfo.inpLimVec = inpLimVec;
    SPlotInfo = get(hFigure, 'UserData');
    a = inpLimVec(1);
    b = inpLimVec(2);
    T = b - a;
    N = 1 + floor(T / step);
    N = round(N / 2) * 2;
    step = T / N;
    L = 2*pi/step;
    if isempty(outLimVec)
        if ~isfield(SPlotInfo, "ax1")
            outLimVec = [0, L];
        else
            outLimVec = SPlotInfo.ax1.XLim;
        end
    end
    outInfo.outLimVec = outLimVec;
    if ~isfield(SPlotInfo, "ax1")
        subplot(2, 1, 1);
        ax1 = gca;
        subplot(2, 1, 2);
        ax2 = gca;
    else
        ax1 = SPlotInfo.ax1;
        ax2 = SPlotInfo.ax2;
        cla(ax1, 'reset');
        cla(ax2, 'reset');
    end
    outInfo.nPoints = N;
    outInfo.step = step;
    outInfo.ax1 = ax1;
    outInfo.ax2 = ax2;
    
    t = a:step:(b-step);
    
    lstep = 2 * pi / T;
    outInfo.lstep = lstep;

    A = outLimVec(1);
    B = outLimVec(2);
    nA = round(A/lstep);
    nB = round(B/lstep);
    

    %l = nA*lstep:lstep:nB*lstep;
    l = 0:lstep:(N-1)*lstep;
    F = fft(fHandle(t)) * step .* exp(-1i * a * l);
    %F = fft(f);
    %F = F(nA+1:nB+1);
    l = nA*lstep:lstep:nB*lstep;
    %{
    for n = 1:nB-nA+1
        F(n) = F(n) * exp(2i * pi * n * nA / N);
    end
    %}
    F1 = zeros(1, nB - nA);
    for i = nA:nB
        F1(i - nA + 1) = F(mod(i - 1, N) + 1);
    end
    %F = [zeros(1, max(-nA, 0)), F(max(nA, 0)+1:min(nB+1, N)), zeros(1, max(nB+1-N, 0))];
    F = F1;
    size(F1)
    size(l)
    plot(ax1, l, real(F));
    plot(ax2, l, imag(F));
    
    if ~isempty(fFTHandle)
        hold(ax1, 'on');
        plot(ax1, l, real(fFTHandle(l)));
        hold(ax1, 'off');
        hold(ax2, 'on');
        plot(ax2, l, imag(fFTHandle(l)));
        hold(ax2, 'off');
    end

    grid(ax1, 'on');
    grid(ax2, 'on');
    xlabel(ax1, '\lambda', 'Interpreter', 'tex');
    ylabel(ax1, 'Re F(\lambda)', 'Interpreter', 'tex');
    xlabel(ax2, '\lambda', 'Interpreter', 'tex');
    ylabel(ax2, 'Im F(\lambda)', 'Interpreter', 'tex');
    if ~isempty(fFTHandle)
        legend(ax1, 'fft', 'analytical', 'Location', 'southeast');
        legend(ax2, 'fft', 'analytical', 'Location', 'southeast');
    else
        legend(ax1, 'fft');
        legend(ax2, 'fft');
    end
    %ax1.YAxis.Limits = [-10 10];
    %ax2.YAxis.Limits = [-10 10];
    %ax1.XAxis.Limits = [-10 100];
    %ax2.XAxis.Limits = [-10 100];
end


function y = func1(t)
    y = atan(t/2) - atan(t);
end

function y = func2(t)
    y = sin(2*t) .* (3*abs(t) <= 1);
end

function y = func3(t)
    y = exp(-2*abs(t)) ./ (1 + 2*atan(t).^2);
end

function y = func4(t)
    y = sin(t.^3) ./ t.^2;
end

function y = ftfunc1(l)
    y = 1i * pi ./ l .* (exp(-l) - exp(-2 * l)) ;
end

function y = ftfunc2(l)
    y = 1i/3*(sinc((2+l)/3/pi) - sinc((2-l)/3/pi));
end
