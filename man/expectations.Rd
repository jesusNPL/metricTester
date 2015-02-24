% Generated by roxygen2 (4.0.2): do not edit by hand
\name{expectations}
\alias{expectations}
\title{Fill in soon}
\usage{
expectations(picante.cdm, tree, regional.abundance = NULL, distances.among,
  randomizations, cores, cluster = FALSE, metrics, nulls, concat.by,
  output.raw = FALSE)
}
\value{
Fill in later
}
\description{
Fill in later
}
\details{
Fill in later
}
\examples{
test <- expectations(cdm, tree, regional.abundance=NULL, distances.among=distances,
	randomizations=3, cores=3, cluster=FALSE,
	nulls=list("dispersal"=metricTester:::my_dispersal),
	metrics=list("richness"=metricTester:::my_richness, "NAW_MPD"=metricTester:::naw_mpd),
	concat.by="both", output.raw=FALSE)
}
\references{
Miller, Trisos and Farine.
}
