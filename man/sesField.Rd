% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sesField.R
\name{sesField}
\alias{sesField}
\title{Calculate a species' standardized trait field}
\usage{
sesField(field.input, metrics, nulls, randomizations, regional.abundance,
  distances.among, cores = "seq")
}
\arguments{
\item{field.input}{Prepped field.input object.}

\item{metrics}{Optional. If not provided, defines the metrics as all of those in
defineMetrics. If only a subset of those metrics is desired, then metrics should take
the form of a character vector corresponding to named functions from defineMetrics.
The available metrics can be determined by running names(defineMetrics()).}

\item{nulls}{Optional. If not provided, defines the nulls as all of those in
defineNulls. If only a subset of those is desired, then nulls should take
the form of a character vector corresponding to named functions from defineNulls.
The available nulls can be determined by running names(defineNulls()).}

\item{randomizations}{The number of times the input CDM should be randomized and the
metrics calculated across it.}

\item{regional.abundance}{A character vector in the form "s1, s1, s1, s2, s2, s3, etc".
Optional, will be generated from the input CDM if not provided.}

\item{distances.among}{A symmetric distance matrix, summarizing the distances among all
quadrats from the cdm. For use with the dispersal null.}

\item{cores}{This function can run in parallel. In order to do so, the user must
specify the desired number of cores to utilize. The default is "seq", which runs the
calculations sequentially.}
}
\value{
Data frame of standardized effect sizes of species' trait fields. Table
includes the observed trait field, the mean and standard deviation of the species'
trait field after randomization with the chosen null model, and the resulting
species-specific standardized effect size.
}
\description{
Calculate the null-model standardized effect size of a species' trait field.
}
\details{
The trait distance matrix should be symmetrical and "complete". See example.
Currently only non-abundance-weighted mean pairwise and interspecific
abundance-weighted mean pairwise phylogenetic distances are implemented. The
only null models that are currently implemented are the richness and dispersal nulls.
The function could be improved by tapping into any of the metrics and nulls defined
in defineMetrics and defineNulls.
}
\examples{
#simulate tree with birth-death process
tree <- geiger::sim.bdtree(b=0.1, d=0, stop="taxa", n=50)

sim.abundances <- round(rlnorm(5000, meanlog=2, sdlog=1)) + 1

cdm <- simulateComm(tree, richness.vector=10:25, abundances=sim.abundances)

#in this example, occasionally some species are not in the CDM, so prune the tree
#accordingly so as not to throw any errors
tree <- drop.tip(tree, setdiff(tree$tip.label, colnames(cdm)))

prepped <- prepFieldData(tree=tree, picante.cdm=cdm)

results <- sesField(prepped, randomizations=3,
metrics="NAW_MPD", nulls="richness")
}
\references{
Miller, Wagner, Harmon & Ricklefs. In review. Radiating despite a lack of
character: closely related, morphologically similar, co-occurring honeyeaters have
diverged ecologically.
}
