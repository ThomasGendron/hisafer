% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read.R
\name{read_hisafe_output_file}
\alias{read_hisafe_output_file}
\title{Read a single Hi-sAFe output profile}
\usage{
read_hisafe_output_file(profile, simu.name)
}
\arguments{
\item{profile}{A character string of the path to the profile to be read.}

\item{simu.name}{A character string of the name of the simulation being read.}
}
\value{
A data frame (tibbles) containing the data from the profile.
}
\description{
Reads the designated output profiles from a single Hi-sAFe simulation.
}
\keyword{internal}
