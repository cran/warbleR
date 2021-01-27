// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// envelope
NumericVector envelope(NumericVector x, int ssmooth);
RcppExport SEXP _warbleR_envelope(SEXP xSEXP, SEXP ssmoothSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< int >::type ssmooth(ssmoothSEXP);
    rcpp_result_gen = Rcpp::wrap(envelope(x, ssmooth));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_warbleR_envelope", (DL_FUNC) &_warbleR_envelope, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_warbleR(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
