
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Bioassays

<!-- badges: start -->

<!-- badges: end -->

'Bioassays' is an R package, designed to provide a wide range of functions relevant to multi-well plate assays. It can handle data from any of the standard multi-well plate format: 6, 12, 24, 96 or 384 well plates. ‘Bioassays’ is an R package, and has supports for formatting, visualizing and analyzing multi-well plate assays. It has functions for handling outliers, for handling multiple data sets with separate blanks, for estimating values from standard curves, for summarizing data and for doing statistical analysis. Moreover, it is strongly documented in a manner designed to be easy for even beginners to grasp. The package has functions for data extraction (extract_filename), formatting (data2plateformat, plate2df, matrix96 and plate_metadata), visualization (heatplate) and data analysis (reduceblank, estimate, dfsummary, pvalue).

## Installation

You can install the released version of bioassays from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("bioassays")
```
From GitHub using
``` r
install_github("anwarbio/bioassays")
```
## Example

Detail’s of various funtions in this package is provided in
‘bioassays-vignette’. Examples on how to use this package is provided
in ‘bioassays-example’ in Vignette.
