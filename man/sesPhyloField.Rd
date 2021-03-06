% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sesPhyloField.R
\name{sesPhyloField}
\alias{sesPhyloField}
\title{Calculate a species' standardized trait field}
\usage{
sesPhyloField(tree, picante.cdm, metric, null, randomizations,
  distances.among = NULL, abundance.matters = TRUE,
  abundance.assigned = "directly", cores = "seq")
}
\arguments{
\item{tree}{Phylo object.}

\item{picante.cdm}{A picante-style community data matrix with sites as rows, and
species as columns.}

\item{metric}{Phylogenetic metric of choice (see details).}

\item{null}{Null model of choice (see details).}

\item{randomizations}{The number of times the input CDM should be randomized and the
metrics calculated across it.}

\item{distances.among}{A symmetric distance matrix, summarizing the distances among all
plots from the cdm. For use with the dispersal null.}

\item{abundance.matters}{Default is TRUE. If FALSE, species are sampled from
neighboring grid cells with equal probability. For use with the dispersal null.}

\item{abundance.assigned}{For use with the dispersal null. See details there.}

\item{cores}{This function can run in parallel. In order to do so, the user must
specify the desired number of cores to utilize. The default is "seq", which runs the
calculations sequentially.}
}
\value{
Data frame of standardized effect sizes of species' phylogenetic fields. Table
includes the observed phylogenetic field, the mean and standard deviation of the
species' trait field after randomization with the chosen null model, and the resulting
species-specific standardized effect size.
}
\description{
Calculate the null-model standardized effect size of a species' trait field.
}
\details{
This function is being deprecated. This and the rest of the first generation
of field functions are being replaced by a two-step process akin to the calcMetrics
set of functions. The user first preps the data with a prep function, then runs the
desired metrics and nulls over the prepped object. This allows sets of metrics to be
calculated over the same randomized matrix, rather than having to repeatedly generate
the same random matrix for each metric.
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

#simulate log-normal abundances
sim.abundances <- round(rlnorm(5000, meanlog=2, sdlog=1)) + 1

#simulate a community data matrix with these inputs
cdm <- simulateComm(tree, richness.vector=10:25, abundances=sim.abundances)

#example trait field calculations
exampleField <- sesPhyloField(tree=tree, picante.cdm=cdm, 
	metric="naw.mpd", null="richness", randomizations=10)
}
\references{
Miller, Wagner, Harmon & Ricklefs. In review. Radiating despite a lack of
character: closely related, morphologically similar, co-occurring honeyeaters have
diverged ecologically.
}
