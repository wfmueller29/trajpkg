% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lcmem.R
\name{lcmem}
\alias{lcmem}
\title{More Generalized hlme}
\usage{
lcmem(
  data,
  fixed,
  mixture,
  random,
  subject,
  k,
  B = NULL,
  idiag = FALSE,
  nwg = FALSE,
  df_sym = NULL,
  silent = TRUE
)
}
\arguments{
\item{data}{the dataframe that we are using to create the model}

\item{fixed}{a string that represents a two-side linear formual object for the fixed effects in a linear mixed model.
By default, an intercept is included. If no intercept, -1 should be the first term included on the right of ~.}

\item{mixture}{a string that represents one-sided formula object for the class-specific fixed effects in the linear mixed model
(to specify only for a number of latent classes greater than 1). Among the list of covariates included in fixed,
the covariates with class-specific regression parameters are entered in mixture separated by +. By default, an intercept is included.
If no intercept, -1 should be the first term included.}

\item{random}{a string that represents an optional one-sided formula for the random-effects in the linear mixed model. Covariates
with a random-effect are separated by +. By default, an intercept is included. If no intercept, -1 should be the first term included.}

\item{subject}{name of the covariate representing the grouping structure specified with ''.}

\item{k}{optional number of latent classes considered. If k=1 (by default) no mixture nor classmb should be specified.
If k>1, mixture is required.}

\item{B}{optional specification for the initial values for the parameters. Three options are allowed:
(1) a vector of initial values is entered (the order in which the parameters are included is detailed in details section).
(2) nothing is specified. A preliminary analysis involving the estimation of a standard linear mixed model is performed to choose initial values.
(3) when ng>1, a hlme object is entered. It should correspond to the exact same structure of model but with ng=1.
The program will automatically generate initial values from this model. This specification avoids the preliminary analysis indicated in (2).
Note that due to possible local maxima, the B vector should be specified and several different starting points should be tried.}

\item{idiag}{optional logical for the structure of the variance-covariance matrix of the random-effects.
If FALSE, a non structured matrix of variance-covariance is considered (by default).
If TRUE a diagonal matrix of variance-covariance is considered.}

\item{nwg}{optional logical indicating if the variance-covariance of the random-effects is class-specific.
If FALSE the variance-covariance matrix is common over latent classes (by default).
If TRUE a class-specific proportional parameter multiplies the variance-covariance matrix in each class
(the proportional parameter in the last latent class equals 1 to ensure identifiability).}

\item{df_sym}{the symbol of that dtaframe given by the data param in the global env.}
}
\value{
It will return a list where the first element is the hlme object and the second element are the list of the input
parameters given to the model.
}
\description{
This function runs the hlme function from the lcmm package, with a few tweaks to make hlme more flexible for looping purposes.
Fixed, mixture, and random parameters are strings. Ng (number of groups in hlme) is k in this function. If k > 1 and B
is not supplied, lcmem will run hlme with k = 1, then use this model as B for the provided k. df is a rlang symbol instead of
a dataframe object.
}
