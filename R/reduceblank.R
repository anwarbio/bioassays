##Function to reduce blank well

#'@importFrom magrittr %>%
#'@importFrom dplyr filter select
#'@export

reduceblank<-function(dataframe,x_vector,blank_vector,y){

# Initial settings#
rowname <- NULL
zzz <- data.frame(stringsAsFactors= FALSE) ## An empty dataframe to dump result
blkdf<-data.frame(stringsAsFactors= FALSE)
dataframe[,y]<-as.numeric(dataframe[,y])


# if x_vector == "All"#
if(identical(x_vector,"All")){
  dataframe$rowname<-as.numeric(rownames(dataframe))

  for (a in seq_along(blank_vector)) {
    ycolumn<-names(dataframe)[which(dataframe == (blank_vector[a]), arr.ind=TRUE)[, "col"]][1]
    blank<-dataframe %>% dplyr::filter (get(ycolumn) == (blank_vector[a]))
    blkdf<-rbind(blkdf,blank)
  }

  meanblank<-mean(blkdf[,y])
  dataframe$blankminus<-dataframe[,y]-meanblank
  dataframe<-dataframe[order(as.numeric(rownames(dataframe))),,drop=FALSE]
  dataframe<-dplyr::select(dataframe,-rowname)
  return(dataframe)
}


# if x_vector =! "All"#

else{

  for (a in seq_along(x_vector)) {

    xcolumn<-names(dataframe)[which(dataframe == (x_vector[a]), arr.ind=TRUE)[, "col"]][1]
    ycolumn<-names(dataframe)[which(dataframe == (blank_vector[a]), arr.ind=TRUE)[, "col"]][1]

    dataframe$rowname<-as.numeric(rownames(dataframe))
    fdf<-dataframe %>% dplyr::filter (get(xcolumn) == (x_vector[a]))
    blank<-fdf %>% dplyr::filter (get(ycolumn) == (blank_vector[a]))
    meanblank<-mean(blank[,y])

    fdf$blankminus<-fdf[,y]-meanblank
    rownames(fdf)<-fdf$rowname
    zzz<-rbind(zzz,fdf)
  }

  zzz<-zzz[order(as.numeric(rownames(zzz))),,drop=FALSE]
  zzz<-dplyr::select(zzz,-rowname)
  return(zzz)
}

}

