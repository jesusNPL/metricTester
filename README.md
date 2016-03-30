# metricTester
## A package to explore and test phylogenetic community structure metrics and null models

Many of these functions are detailed in [our Ecography paper](http://onlinelibrary.wiley.com/doi/10.1111/ecog.02070/abstract) that reviews phylogenetic community structure metrics and null models.

#### Why should I use metricTester?
metricTester allows users to define their own spatial simulations, null models, and metrics. A variety of functions then allow users to explore the behavior of these methods (e.g., across varying species richness), and their statistical performance (e.g., ability to detect a pattern in the spatial simulations). Although originally programmed specifically for phylogenetic community structure methods, the package is flexible enough that simulations, models, and metrics can be defined on the fly, and it can harness multiple cores to quickly generate expectations. Thus, beyond phylogenetic community structure methods, some may find this package useful for exploring the behavior of any user-defined row- or column-wise matrix calculations as the matrix is repeatedly shuffled according to any user-defined algorithm.

#### How do I use metricTester?
All exported functions are carefully documented and illustrated with examples. To illustrate some of the general functionality of metricTester, here's how you would install (from GitHub), generate a community data matrix (where plots are rows and species are columns), then calculate an arbitrary row-wise metric repeatedly as the community data matrix is repeatedly randomized according to an arbitrary null model.
```
library(devtools)
install_github("metricTester/eliotmiller")
library(metricTester)

#simulate tree with birth-death process
tree <- geiger::sim.bdtree(b=0.1, d=0, stop="taxa", n=50)

#simulate a log-normal abundance distribution
sim.abundances <- round(rlnorm(5000, meanlog=2, sdlog=1)) + 1

#sample from that distribution to create a community data matrix of varying species 
#richness
cdm <- simulateComm(tree, richness.vector=10:25, abundances=sim.abundances)

#define a new metric. here we will simply calculate the total abundance (i.e. the total
#number of individuals of any species) per plot.
tempMetric <- function(input.vector)
{
	nonZeros <- input.vector[input.vector != 0]
	return(length(nonZeros))
}

#write a quick wrapper to apply the new metric over a community data matrix
dummyMetric <- function(metrics.input)
{
	results <- apply(metrics.input$picante.cdm, 1, tempMetric)
	results
}

#define a new null model. here we will simply completely shuffle the contents of the
#community data matrix
dummyNull <- function(nulls.input)
{
	results <- matrix(nrow=dim(nulls.input$picante.cdm)[1],
	ncol=dim(nulls.input$picante.cdm)[2], sample(unlist(nulls.input$picante.cdm)))
	rownames(results) <- row.names(nulls.input$picante.cdm)
	colnames(results) <- names(nulls.input$picante.cdm)
	results
}
```
#see what we expect plot-level total abundance to be after repeatedly randomizing the
#matrix 100 times
expectations(tree=tree, picante.cdm=cdm, nulls=list("fullShuffle"=dummyNull),
metrics=list("richness"=metricTester:::my_richness, "totalAbund"=dummyMetric),
randomizations=100, concat.by="plot")

#### How do I get it?
metricTester will soon be available on CRAN. Updates may also be available more frequently/sooner via the [GitHub site](https://github.com/eliotmiller/metricTester/). See above for how to install directly from GitHub.

#### The software DOI released in conjunction with our Ecography paper is available [here](https://zenodo.org/badge/latestdoi/21050/eliotmiller/metricTester).

The phylogenetic and trait field functions (`phyloField`, `traitField`, `sesPhyloField`, and `sesTraitField`) are explained in a paper with Sarah Wagner, Luke Harmon, and Robert Ricklefs on [honeyeater ecomorphology](http://www.biorxiv.org/content/early/2015/12/14/034389).

**Note** that these field functions  are currently limited to three metrics and two null models. I am working on a more general adaptation of these approaches to the metricTester framework. Specifically, users will prep their data like they already do with `prepData`, then calculate the actual metric(s) and null model(s) of their choice on the prepped object with a function like `calcMetrics`. This soon-to-come function will detect whether to calculate the phylogenetic or trait field based on the inputs in the prepped object. **These updates are liable to break the current field functions**, although I intend to deprecate the current functions for some period of time to minimize conflicts.