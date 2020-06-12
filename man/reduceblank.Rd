\name{reduceblank}

\alias{reduceblank}

\title{Reduce Blank Values}

\description{This function can reduce 'blank' value from readings. Can handle separate blanks for separate groups in the dataframe}

\usage{
reduceblank(dataframe, x_vector, blank_vector, y)
}

\arguments{
  \item{dataframe}{Data in the form of dataframe.}
  \item{x_vector}{A character vector of groups/entries for which the blank has to be reduced.}
  \item{blank_vector}{A character vector of blank names whose value has to be reduced.}
  \item{y}{Name of the column (column should be numeric in nature) whose values has be reduced.}
}
\details{
 This function will reduce the first blank vector element from first x_vector element and so on.}

\value{
A dataframe with a new column 'blankminus' (result of the blankminus function) added to the right.
}

\author{
A.A Palakkan
}

\examples{
## loading data
data(metafile384, rawdata384)
rawdata<-plate2df(data2plateformat(rawdata384,platetype = 384))
data_DF2<- dplyr::inner_join(rawdata,metafile384,by=c("row","col","position"))

## eg:1 reduce blanks of data_DF2.
  # reduce seperate blanks (mean of blank wells) for drug1, drug2, drug3 and drug4.
  #blanks are blank1, blank2, blank3 and blank4 respectively for different drugs.

data_blk<-reduceblank(data_DF2,
          x_vector=c("drug1","drug2","drug3","drug4"),
          blank_vector = c("blank1","blank2","blank3","blank4"), "value")


}

\keyword{ manip}

