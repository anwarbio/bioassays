
# function to extract details from file name
#' @export

extract_filename<-function(filename,split = " ",end = ".csv", remove = " ", sep="-"){

a<-basename(as.character(filename))
name <- unlist(strsplit(a,end,fixed = TRUE))[1] # remove .csv from the end
nm2<-unlist(strsplit(name, split)) # split the file name in to different parts.
nm3<-nm2

for (j in seq_along(remove)) {
  for (i in seq_along(nm2)) {if (nm2[i]==remove[j]) nm3[i]<-" "}
}

cell<- paste(nm3[which(nm3!=" ")], collapse = sep)
nm4<- nm3[which(nm3!=" ")]
ab_name<-c(a,cell,nm4)
return(ab_name)
}

