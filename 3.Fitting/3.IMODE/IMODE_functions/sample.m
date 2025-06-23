clc; clear;

f = @(x) x(1).^2 + x(2).^2;
D = 2;
Space_min = -500*ones(1,D);
Space_max = 500*ones(1,D);
[bestx, bestf] = IMODE_basic(f,D, Space_min, Space_max);
disp(bestx);
disp(bestf);