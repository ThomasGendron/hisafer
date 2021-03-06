% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc.R
\name{get_pheno_dates}
\alias{get_pheno_dates}
\title{Get dates of tree phenological stage changes from a hop}
\usage{
get_pheno_dates(hop, tree.ids = 1)
}
\arguments{
\item{hop}{An object of class hop or face.}

\item{tree.ids}{A numeric vector of the values of idTree to include.}
}
\value{
A tibble (data.frame)
}
\description{
Gets dates of tree phenological stage changes from a hop in a format suitable for supplementing plots.
}
\examples{
\dontrun{
pheno.dates <- get_pheno_dates(hop)
}
}
\seealso{
Other hisafe helper functions: \code{\link{copy_hisafe_template}},
  \code{\link{get_pruning_dates}},
  \code{\link{hip_params}}, \code{\link{hisafe_info}},
  \code{\link{hisafe_profiles}}, \code{\link{hop_filter}},
  \code{\link{hop_merge}}, \code{\link{hop_params}},
  \code{\link{hop_rename}}, \code{\link{is_face}},
  \code{\link{is_hip}}, \code{\link{is_hop}},
  \code{\link{join_profiles}},
  \code{\link{make_rel_years}},
  \code{\link{profile_check}},
  \code{\link{variable_check}},
  \code{\link{which_profiles}}
}
\concept{hisafe helper functions}
