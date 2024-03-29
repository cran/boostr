% Generated by roxygen2 (4.0.0): do not edit by hand
\name{wrapPerformanceAnalyzer}
\alias{wrapPerformanceAnalyzer}
\title{Create a boostr compatible wrapper for a performance analyzer.}
\usage{
wrapPerformanceAnalyzer(analyzePerformance, analyzerInputPreds = "prediction",
  analyzerInputResponse = "response", analyzerInputOOBObs = "oobObs",
  .verbose = FALSE)
}
\arguments{
\item{analyzePerformance}{a function to analyze the performance of an estimator}

\item{analyzerInputPreds}{a string indicating the name of the argument in
\code{analyzePerformance}'s signature that represents the estimator's
predictions.}

\item{analyzerInputResponse}{a string indicating the name of the argument in
\code{analyzePerformance}'s signature that represents the true response
associated with the estimator's predictions.}

\item{analyzerInputOOBObs}{a string indiciating the name of the argument in
\code{analyzePerformance}'s signature that represents the vector of indices
indicating which observations were out-of-bag.}

\item{.verbose}{a boolean indicating if warnings should be displayed or not.}
}
\value{
A function (wrapper around \code{analyzePerformance}) which is also
a '\code{performanceAnalyzer}' object. The function's signature is
\code{(prediction, response, oobObs, ...)} and it's output preserves the
 output of \code{analyzePerformance}. Hence, the wrapper is a boostr
compatible performance analyzer.
}
\description{
Use provided metadata on a given performance analyzer to create
a boostr compatible wrapper.
}
\details{
Since "performance" is a subjective thing, the requirements for a function to
be wrappable by \code{\link{wrapPerformanceAnalyzer}} are that they accept
predictions, true responses, and a vector of indices for out-of-bag
observations. After each iteration of the ensemble building phase in
\code{\link{boostBackend}}, these three objects are fed to a performance
analyzer. The output of the performance analyze is stored in the
\code{estimatorPerformance} attribute of the object returned by
\code{\link{boostBackend}}.
}
\section{Performance Analyzers}{

Any function which can accept an estimator's predictions, as well as the true
responses can be used as a "performance analyzer" in \code{\link{boost}}.
That is, if the signature of a function can be transformed to
\code{(predictions, responses, ...)}, then
\code{\link{wrapPerformanceAnalyzer}} can be run on the function, and the
results can be used by \code{\link{boostBackend}}. The output of the
performance analyzer is entirely preserved, and can be accessed by running
\code{\link{estimatorPerformance}} on the resulting '\code{boostr}' object.

At every iteration of the ensemble building phase, \code{\link{boostBackend}}
passes \code{performance Analysis}:
\itemize{
 \item{the newly built estimator's predicted responses for each row in
  \code{data}.}
 \item{the true response for each row in \code{data}.}
 \item{the indices of the observations in \code{data} that were not included
 in the sample of \code{data} that went into creating the estimator. This
 variable is passed in as \code{oobObs}.}
 \item{whatever other named arguments were passed from \code{\link{boost}}
 through the \code{...}'s.}
}
Hence, an analyzer can accept all three values (and then some) to perform
whatever analysis is desired on an individual estimator.

For example, the stock performance analyzer for classification,
\code{\link{defaultOOBPerformanceAnalysis}}, has signature
\code{(prediction, response, oobObs)} and calculates
an individual, out-of-bag, misclassification vector, the overall out-of-bag
error rate, and the confusion matrix for a particular estimator, given the
information passed to it.
}
\seealso{
Other Wrapper Generators: \code{\link{buildEstimationProcedure}};
  \code{\link{wrapAggregator}};
  \code{\link{wrapProcedure}}; \code{\link{wrapReweighter}}
}

