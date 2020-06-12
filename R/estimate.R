#'@importFrom nplr getEstimates
#'@importFrom stats coefficients
#'@export

estimate<-function(data,colname="blankminus",fitformula=fiteq, method="linear/nplr"){

fiteq<-NULL

if(method=="nplr"){
  projected <- nplr::getEstimates(fitformula,targets=data[,colname],conf.level= .95)[c(3)]
  newlayout<-data.frame(cbind(data,estimated=projected))
  colnames(newlayout)[ncol(newlayout)]<-"estimated"
  return(newlayout)
}

if(method=="linear") {
  coe<-stats::coefficients(fitformula)
  names(coe)<-NULL
  xvalue<-data[,colname]
  projected<-coe[1]+(coe[2]*xvalue)
  newlayout<-data.frame(cbind(data,estimated=projected))
  colnames(newlayout)[ncol(newlayout)]<-"estimated"
  return(newlayout)
}

}
