\name{plate_metadata}
\alias{plate_metadata}

\title{Combining Plate Specific Information with Metadata}
\description{
plate_metadata combine the plate specific information (like compounds used, standard concentration, dilution of samples, etc) and metadata, to produce a plate specific metadata.
}
\usage{
plate_metadata (plate_details, metadata, mergeby = "type")
}

\arguments{
  \item{plate_details}{plate specific information that need to be added to metadata}
  \item{metadata}{metadata for whole experiment}
  \item{mergeby}{column that is common to both metadata and plate_meta (as a string in "")}
}
\details{
plate_details need to be in a list format. Metadata should have a 'row' and 'col' columns representing the row and column names of the corresponding multi well plate.
}
\value{
 A dataframe. Each element of 'plate_details' will appear as a new column to the left of 'metadata'

}

\author{
A.A Palakkan
}

\examples{
## loading data
data(metafile96)
plate_details <- list("compound" = "Taxol",
                "concentration" = c(0.00,0.01,0.02,0.05,0.10,1.00,5.00,10.00),
                "type" = c("S1","S2","S3","S4","S5","S6","S7","S8"),
                "dilution" = 1)

## eg:1 filling metadata96 using plate_details
plate_meta<-plate_metadata(plate_details,metafile96,mergeby="type")
head(plate_meta)


}

\keyword{ manip }
