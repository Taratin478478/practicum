clc; clear; close all;

X = [1, 2; 3, 4];
X = complex(X);
N = 5;

Y = countcos(X, N);
err = abs(Y - cos(X));
disp(Y);
disp(cos(X));
disp(err);

X0 = [0, 1; 2, 3];
X0 = complex(X0);
CX0 = complex(cos(X0));
SX0 = complex(sin(X0));

Y = countcos(X, N, X0, CX0, SX0);
err = abs(Y - cos(X));
disp(Y);
disp(cos(X));
disp(err);

X = [1 + 1i, 2 + 2i; 3 + 3i, 4 + 4i];
X = complex(X);
X0 = [0, 1 - 1i; 2 - 2i, 3 - 3i];
X0 = complex(X0);
CX0 = complex(cos(X0));
SX0 = complex(sin(X0));

Y = countcos(X, N, X0, CX0, SX0);
err = abs(Y - cos(X));
disp(Y);
disp(cos(X));
disp(err);
