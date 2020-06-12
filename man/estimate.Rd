\name{estimate}
\alias{estimate}

\title{Estimating Variable Based on Standard Curve}

\description{ This function will estimate the unknown variable (example: concentration) based on a standard curve.}

\usage{ estimate (data, colname = "blankminus", fitformula = fiteq, method = "linear/nplr")
}

\arguments{
  \item{data}{data in dataframe format}
  \item{colname}{column name whose values has to be estimated}
  \item{fitformula}{formula used for fitting standard curve}
  \item{method}{method = "linear" if standard curve is linear in nature. method = "nplr" if standard curve is nonparametric logistic curve.}

}
\details{
For linear standard curve 'fitformula' need to generated using \code{\link[stats]{lm}}.
For nonparametric logistic curve 'fitformula' need to generated using \code{\link[nplr]{nplr}}.
}
\value{
A dataframe with estimated values added to right as a new column "estimated".

}

\author{
A.A Palakkan
}

\examples{
## loading data
data(data_DF1)

## Filtering standards
std<- dplyr::filter(data_DF1, data_DF1$id=="STD")
std <- aggregate(std$blankminus ~ std$concentration, FUN = mean )
colnames (std) <-c("con", "OD")

## 3-parametric regression curve fitting
fit1<-nplr::nplr(std$con,std$OD,npars=3,useLog = FALSE)

## Linear regression curve fitting
fit2<- stats::lm(formula = con ~ OD,data = std)

## Estimating the 'blankminus'
## eg:1 Based on nonparametric logistic regression fitting
estimated_nplr <- estimate(data_DF1,colname = "blankminus",fitformula = fit1,method = "nplr")

## eg:2 Based on linear regression fitting
estimated_lr<-estimate(data_DF1,colname="blankminus",fitformula=fit2,method="linear")

}

\keyword{ math }

