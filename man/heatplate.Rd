\name{heatplate}
\alias{heatplate}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Heatmap of multi well plate}
\description{
This function generate a heatmap (for numeric vector) or categorical plot (character vector) of multi well plate}
\usage{
heatplate(datamatrix, name, size = 7.5)
}

\arguments{
  \item{datamatrix}{data in matrix format. An easy way to create this is by calling \code{\link{matrix96}}}
  \item{name}{name to be given for the heatmap}
  \item{size}{plot size for each well in the heatmap (default is 7.5)}
}
\details{
Heat map can be generated for any multi well plate data in matrix format (datamatrix). The columns and rows of datamatrix should be labelled appropriately using \code{\link{matrix96}}. A heatplot is generated if datamatrix is numeric, but a categorical plot is generated if datamatrix is a character matrix.
}
\value{
A graphical plot.

}

\author{
A.A Palakkan
}

\examples{
## loading data
data(metafile96, rawdata96,rawdata384)
rawdata96 <- data2plateformat(rawdata96,platetype = 96)
rawdata384 <- data2plateformat(rawdata384,platetype = 384)

## eg:1 heat map of rawdata96
data<-matrix96(plate2df(rawdata96),"value")
heatplate(data,"Plate 1", size=5)

## eg:2 heat map of rawdata96 can also be called as
heatplate(as.matrix(rawdata96),"Plate 1", size=5)

## eg:3 heat map of rawdata384
heatplate(as.matrix(rawdata384),"Plate 1", size=2)

## eg:4 catagorical map of metafile96 (column:id)
data<-matrix96(metafile96,"id")
heatplate(data,"Plate 1", size=5)

}

\keyword{ hplot }
