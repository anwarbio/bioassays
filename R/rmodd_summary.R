
## Function to remove the outliers if cv is grater than the preset value
## x is data, y is the cv requred, defult cvi s 80%

#'@importFrom stats median sd quantile IQR
#'@export

rmodd_summary <- function (x, rm = "FALSE", strict= "FALSE", cutoff=80,n=3 ) {

## intial setup ###
z1<-c(mean(x),stats::median(x),length(x),stats::sd(x),stats::sd(x)/mean(x)*100)

## rm == FALSE ###
if(rm=="FALSE"){names(z1)<-c("mean","median","n","sd","cv")
return(z1)}

## rm == TRUE & strict ==FALSE, cv < cutoff ###
if(rm=="TRUE"){
  if(z1[5]< cutoff & strict == "FALSE") {names(z1)<-c("mean","median","n","sd","cv")
  return(z1)}

## rm == TRUE & strict ==FALSE, cv > cutoff ###
  if(z1[5]> cutoff & strict == "FALSE") {
    Q <- stats::quantile(x,probs=c(0.25,0.75),na.rm=FALSE)
    iqr <- stats::IQR(x)
    up <-  Q[2]+1.5*iqr # Upper Range
    low<- Q[1]-1.5*iqr # Lower Range
    x<- subset(x, (x > low & x < up))
    z1<-c(mean(x),stats::median(x),length(x),stats::sd(x),stats::sd(x)/mean(x)*100)
    names(z1)<-c("mean","median","n","sd","cv")
    return(z1)
    }

## rm == TRUE & strict ==TRUE, cv > cutoff ###
  zn<-z1
  cycle<-0
  while (abs(z1[5])> cutoff & strict == "TRUE") {
    cycle<-cycle+1
    up_P<-1-0.1*cycle
    low_P<-0.1*cycle
    temp1<-x[which(!(x> stats::quantile(x,probs=up_P)))]
    z2<-c(mean(temp1),stats::median(temp1),length(temp1),stats::sd(temp1)/mean(temp1)*100)
    d2<-abs(zn[2]-z2[2])

    temp2<-x[which(!(x < stats::quantile(x,probs=low_P)))]
    z3<-c(mean(temp2),stats::median(temp2),length(temp2),stats::sd(temp2)/mean(temp2)*100)
    d3<-abs(zn[2]-z3[2])

    if (d2<d3) {out<-which(!(x < stats::quantile(x,probs=low_P) | x >= stats::quantile(x,probs=up_P)))}
    if(d2>d3){out<-which(!(x <= stats::quantile(x,probs=low_P) | x > stats::quantile(x,probs=up_P)))}
    if (d2==d3){out<-which(!(x < stats::quantile(x,probs=low_P) | x > stats::quantile(x,probs=up_P)))}

    x<-x[out]
    z1new<-c(mean(x),stats::median(x),length(x),stats::sd(x),stats::sd(x)/mean(x)*100)
    if(z1new[3]<=n){break}
    z1<-z1new
    names(z1)<-c("mean","median","n","sd","cv")
  }
  return(z1)
}

}




