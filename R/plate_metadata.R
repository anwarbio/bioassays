
#'@importFrom magrittr %>%
#'@importFrom dplyr arrange select rename inner_join
#'@export

plate_metadata <- function (plate_details, metadata,mergeby="type"){

# Initial setup #
position <- NULL
plate_meta <- plate_details
plate_meta<-as.data.frame(plate_meta)


plate_metadata<-merge(metadata,plate_meta,by=mergeby, all=TRUE)

plate_metadata$concentration.y <- as.numeric(plate_metadata$concentration.y)
plate_metadata$concentration.x <- as.numeric(plate_metadata$concentration.x)
plate_metadata$dilution.x <- as.numeric(plate_metadata$dilution.x)
plate_metadata$dilution.y <- as.numeric(plate_metadata$dilution.y)


plate_metadata<- dplyr::arrange(plate_metadata,position)
row.names(plate_metadata)<-c(seq(1,nrow(plate_metadata),1))



for (c in seq_along(rownames(plate_metadata))) {

  if(is.na(plate_metadata[c,("dilution.x")]))
    {plate_metadata[c,("dilution.x")] <- plate_metadata[c,("dilution.y")]}


  if(is.na(plate_metadata[c,("concentration.x")]))
  {plate_metadata[c,("concentration.x")]<-plate_metadata[c,("concentration.y")]}
}

plate_metadata<-plate_metadata[(!is.na(plate_metadata$position)),]

plate_metadata<- plate_metadata %>%
  dplyr::select(c("row","col","type","position","id","dilution.x","concentration.x","compound"))
plate_metadata <- dplyr::rename(plate_metadata, c("dilution" = "dilution.x", "concentration" = "concentration.x"))
plate_metadata <- plate_metadata[order(plate_metadata$position),]
row.names(plate_metadata) <- seq(1,nrow(plate_metadata),1)

return(plate_metadata)
}
