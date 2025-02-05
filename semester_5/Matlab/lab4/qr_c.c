#include "mex.h"
#include "math.h"

void matrixMultiply(double* P, double* A, double* B, int m, int n, int p) {
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < p; ++j) {
            P[i + j * m] = 0;
            for (int s = 0; s < n; ++s) {
                P[i + j * m] += A[i + s * m] * B[s + j * n];
            }
        }
    }
}

void transpose(double* P, double* A, int m, int n) {
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            P[j + i * m] = A[i + j * m];
        }
    }
}

void makeEye(double* P, int n) {
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (i == j) {
                P[i + j * n] = 1;
            }
            else {
                P[i + j * n] = 0;
            }
        }
    }
}

void copyMatrix(double* P, double* A, int m, int n) {
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            P[i + j * m] = A[i + j * m];
        }
    }
}

void QR_decomposition(double* Q, double* R, double* A, int m, int n) {
    copyMatrix(R, A, m, n);
    makeEye(Q, m);
    double *Qn = (double *) malloc(m * m * sizeof(double));
    double *QnT = (double *) malloc(m * m * sizeof(double));
    double *Rn = (double *) malloc(m * n * sizeof(double));
    double u[m];
    double norm;
    for (int i = 0; i < n - 1; ++i) {
        norm = 0;
        for (int j = i; j < m; ++j) {
            u[j] = R[m * i + j];
            norm += u[j]*u[j];
        }
        norm = sqrt(norm);
        u[i] -= norm;
        norm = 0;
        for (int j = i; j < m; ++j) {
            norm += u[j]*u[j];
        }
        norm = sqrt(norm);
        if (norm != 0) {
            for (int j = i; j < m; ++j) {
                u[j] /= norm;
            }
        }
        makeEye(Qn, m);
        for (int j = i; j < m; ++j) {
            for (int k = i; k < m; ++k) {
                Qn[m * j + k] -= 2 * u[j] * u[k];
            }
        }
        copyMatrix(Rn, R, m, n);
        matrixMultiply(R, Qn, Rn, m, m, n);
        transpose(QnT, Qn, m, m);
        copyMatrix(Qn, Q, m, m);
        matrixMultiply(Q, Qn, QnT, m, m, m);
    }
    free(Qn);
    free(QnT);
    free(Rn);
}

void mexFunction(int nlhs, mxArray* plhs[],
    int nrhs, const mxArray* prhs[])
{
    double* A, * Q, * R;
    int m, n, mA, nA, mQ, nQ, mR, nR;

    if (nrhs != 1) {
        mexErrMsgTxt("One input required");
    }

    if (nlhs != 2) {
        mexErrMsgTxt("Two outputs required");
    }

    A = mxGetPr(prhs[0]); /* real part */

    mA = mxGetM(prhs[0]);
    nA = mxGetN(prhs[0]);

    plhs[0] = mxCreateDoubleMatrix(mA, mA, mxREAL);
    plhs[1] = mxCreateDoubleMatrix(mA, nA, mxREAL);

    Q = mxGetPr(plhs[0]); /* real part */
    R = mxGetPr(plhs[1]); /* real part */

    QR_decomposition(Q, R, A, mA, nA);
}