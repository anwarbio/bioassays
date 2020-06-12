# function to view the dataframe as a matrix of appropriate multiwell format
#df=dataframe to be formatted, col =column to be viewed in 96 well format, rm= assing -ve and NA as 0 if "true"
#' @export

matrix96 <- function(dataframe,column,rm="FALSE"){

if(is.numeric(column)){data<-matrix(dataframe[,column],ncol=length(unique(dataframe[,2])), byrow = TRUE)}

if(!is.numeric(column)){
  name<- as.character(column)
  col<- which(colnames(dataframe)==name)
  data<-matrix(dataframe[,col],ncol=length(unique(dataframe[,2])), byrow = TRUE)
}

rownames(data)<-unique(dataframe$row)
colnames(data)<-unique(dataframe$col)

if(rm==TRUE){
  data[is.na(data)] <- 0
  data[(data<0)]<-0
}

return(data)

}
