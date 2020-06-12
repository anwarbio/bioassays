# Function to convert martrix of 96 well plate to df format
#' @export
plate2df<- function (datamatrix){

position <- value <- NULL
platelayout <- data.frame(row = rep(rownames(datamatrix),length(colnames(datamatrix)))
                             , col = rep(colnames(datamatrix),each =length(rownames(datamatrix))))

platelayout$col<-formatC(platelayout$col, width = 2,flag = 0)
platelayout$position <- paste0(platelayout$row,sprintf("%02d", as.numeric(platelayout$col)))

#platelayout$position <- paste0(platelayout$row, platelayout$col)
#platelayout$position <- sub("^(.)(.)$", "\\10\\2", platelayout$position, perl=T)
platelayout <- platelayout[order(platelayout$position),]
rownames(platelayout)<-c(seq_along(rownames(platelayout)))

platelayout$value<-0
for(i in seq_along(rownames(platelayout)))
{platelayout[i,4]<-datamatrix[as.character(platelayout[i,]$row),as.numeric(platelayout[i,]$col)]}


platelayout <- transform(
                  platelayout,
                  row=as.character(row),
                  col=as.integer(col),
                  position=as.character(position),
                  value=as.numeric(value))

return(platelayout)
}


