#include <mex.h>
#include <math.h>
#include <complex.h>

void countcos(double *XR, double *XI, int N, double *X0R, double *X0I, double *CX0R, double *CX0I, double *SX0R, double *SX0I, int m, int n, double *YR, double *YI) {
	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j) {
			int sign = 1;
			double complex val = 1;
			double complex CX0 = CX0R[m * i  + j] + I * CX0I[m * i  + j];
			double complex SX0 = SX0R[m * i  + j] + I * SX0I[m * i  + j];
			double complex Y = CX0;
			double complex X = XR[m * i  + j] + I * XI[m * i  + j];
			double complex X0 = X0R[m * i  + j] + I * X0I[m * i  + j];
			for (int k = 1; k < N; ++k) {
				val = val * (X - X0) / k;
				if (k % 4 == 1 || k % 4 == 3) {
					sign *= -1;
				}
				if (k % 2 == 0) {
					Y += sign * CX0 * val;
				} else {
					Y += sign * SX0 * val;
				}
			}
			YR[m * i + j] = creal(Y);
			YI[m * i + j] = cimag(Y);
		}
	}
}

void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
	double *XR, *XI, *X0R, *X0I, *CX0R, *CX0I, *SX0R, *SX0I, *YR, *YI;
	int N, m, n, m1, n1;
	if (nrhs < 2 || nrhs > 5) {
		mexErrMsgTxt("Wrong number of arguments.");
	}
  	if (nlhs != 1) {
    	mexErrMsgTxt("One output required.");
  	}

  	m = mxGetM(prhs[0]);
  	n = mxGetN(prhs[0]);
  	if (nlhs >= 3) {
  		m1 = mxGetM(prhs[2]);
  		n1 = mxGetN(prhs[2]);
  		if (n1 != n || m1 != m) {
  			mexErrMsgTxt("Matrix dimensions do not match");
  		}
	}
	if (nlhs >= 4) {
  		m1 = mxGetM(prhs[3]);
  		n1 = mxGetN(prhs[3]);
  		if (n1 != n || m1 != m) {
  			mexErrMsgTxt("Matrix dimensions do not match");
  		}
	}
	if (nlhs >= 5) {
  		m1 = mxGetM(prhs[4]);
  		n1 = mxGetN(prhs[4]);
  		if (n1 != n || m1 != m) {
  			mexErrMsgTxt("Matrix dimensions do not match");
  		}
	}
	N = mxGetScalar(prhs[1]);
  	if (N < 1) {
  		mexErrMsgTxt("N must be a natural number");
  	}

	plhs[0] = mxCreateDoubleMatrix(m, n, mxCOMPLEX);
  	YR = mxGetPr(plhs[0]);
  	YI = mxGetPi(plhs[0]);
  	
    XR = mxGetPr(prhs[0]);
    XI = mxGetPi(prhs[0]);

  	if (nrhs >= 3) {
  		X0R = mxGetPr(prhs[2]);
  		X0I = mxGetPi(prhs[2]);
  	} else {
  		X0R = (double *) malloc(n * m * sizeof(double));
  		X0I = (double *) malloc(n * m * sizeof(double));
  		for (int i = 0; i < m; ++i) {
			for (int j = 0; j < n; ++j) {
				X0R[m * i + j] = 0;
				X0I[m * i + j] = 0;
			}
		}
  	}
  	if (nrhs >= 4) {
  		CX0R = mxGetPr(prhs[3]);
  		CX0I = mxGetPi(prhs[3]);

  	} else {
  		CX0R = (double *) malloc(n * m * sizeof(double));
  		CX0I = (double *) malloc(n * m * sizeof(double));
  		for (int i = 0; i < m; ++i) {
			for (int j = 0; j < n; ++j) {
				double complex val = cos(X0R[m * i + j] + I * X0I[m * i + j]);
				CX0R[m * i + j] = creal(val);
				CX0I[m * i + j] = cimag(val);
			}
		}
  	}
  	if (nrhs >= 5) {
  		SX0R = mxGetPr(prhs[4]);
  		SX0I = mxGetPi(prhs[4]);
  	} else {
  		SX0R = (double *) malloc(n * m * sizeof(double));
  		SX0I = (double *) malloc(n * m * sizeof(double));
  		for (int i = 0; i < m; ++i) {
			for (int j = 0; j < n; ++j) {
				double complex val = sin(X0R[m * i + j] + I * X0I[m * i + j]);
				SX0R[m * i + j] = creal(val);
				SX0I[m * i + j] = cimag(val);
			}
		}
  	}
     
  
  	countcos(XR, XI, N, X0R, X0I, CX0R, CX0I, SX0R, SX0I, m, n, YR, YI);   
}