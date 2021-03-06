\name{dfsummary}
\alias{dfsummary}

\title{Summarize a Dataframe After Grouping Samples}
\description{
This function summarize the dataframe (based on a column). It has additional controls to group samples and to omit variables not needed.
}
\usage{ dfsummary(dataframe, y, grp_vector, rm_vector, nickname, rm="FALSE", param)
}

\arguments{
  \item{dataframe}{data in dataframe format}
  \item{y}{column name whose values has to be summarized (column elements need to be numeric)}
  \item{grp_vector}{a character vector of column names whose order indicate the order of grouping}
  \item{rm_vector}{a character vector of items that need to be omitted before summarizing}
  \item{nickname}{label name for the entries in output dataframe}
  \item{rm}{rm = “FALSE” if outliers not to be removed. rm = “TRUE” If outliers to be removed}
\item{param}{a vector of parameters for more stringent outlier removal. param has to be entered in the format c(strict, cutoff, n). For details please refer \code{\link{rmodd_summary}}:.}
}
\details{
This function first remove 'rm_vector' elements from the 'dataframe'. Samples are grouped (each level of a 'grp_vector' element as separate group) and sorted (based on 'grp_vector' elements order). column 'y' is then summarized for each group (please refer \code{\link{rmodd_summary}}: for details).
}

\value{
A dataframe. First columns are named as grp_vector elements. Followed by a 'label' column (element is 'nickname').This 'label' column will be useful when analyzing multiple plates. Summary statistics of 'y' appear as columns: N (number of samples/group), Mean (average/group), SD (standard deviation/group) and  CV (percentage cv/group).

}

\author{
A.A Palakkan

}

\examples{
## loading data
data(metafile384, rawdata384)
rawdata<-plate2df(data2plateformat(rawdata384,platetype = 384))
data_DF2<- dplyr::inner_join(rawdata,metafile384,by=c("row","col","position"))

## eg:1 summarising the 'value' after grouping samples and omitting blanks.
  # grouping order cell, compound, concentration and type.

result2 <- dfsummary(data_DF2,y = "value",
           grp_vector = c("cell","compound","concentration","type"),
           rm_vector = c("blank1","blank2","blank3","blank4"),
           nickname = "384well",
           rm = "FALSE",param = c(strict="FALSE",cutoff=40,n=12))

}

\keyword{ arith }

