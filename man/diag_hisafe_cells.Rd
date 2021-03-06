% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/diagnostics.R
\name{diag_hisafe_cells}
\alias{diag_hisafe_cells}
\title{Plot cells diagnostics of Hi-sAFe output}
\usage{
diag_hisafe_cells(hop, dates = unique(grep("-07-01",
  as.character(hop$cells$Date), value = TRUE))[seq(1, 40, 5)],
  output.path = NULL, ...)
}
\arguments{
\item{hop}{An object of class "hop" or "face" containing output data from one or more Hi-sAFe simulations.}

\item{dates}{A character vector (in the format "YYYY-MM-DD") or a vector of class Date of the dates to include.}

\item{output.path}{A character stting indicating the path to the directory where plots should be saved. Plots are
saved in a subdirectory within this directory named /annualCells
If no value is provided, the experiment/simulation path is read from the hop object, and a directory is created there called "analysis/diagnostics".}

\item{...}{Other arguments passed to \code{\link{plot_hisafe_cells}}.}
}
\value{
Invisibly returns a list of \code{ggplot} objects.
}
\description{
Creates a tile plot of every Hi-sAFe cells output variable. All plots are saved as png files to a specifified output path.
}
\examples{
\dontrun{
# After reading in Hi-sAFe simulation data via:
mydata <- read_hisafe(path = "mydir", simu.names = "MySimulation")

# You can create tile plots of every annualCells variable:
diag_hisafe_cells(mydata, "2000-07-01")
}
}
\seealso{
Other hisafe diagnostic fucntions: \code{\link{diag_hisafe_annualcells}},
  \code{\link{diag_hisafe_monthcells}},
  \code{\link{diag_hisafe_ts}},
  \code{\link{diag_hisafe_voxels}}
}
\concept{hisafe diagnostic fucntions}
